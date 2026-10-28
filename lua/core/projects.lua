-- Recent projects: a tiny JSON-backed list so you can launch Neovide anywhere
-- (e.g. straight in $HOME) and jump into a project from inside.
--
-- project.nvim is in manual_mode, so it never records history and its Telescope
-- picker stays empty; this is self-contained instead.
local M = {}

local store = vim.fn.stdpath 'data' .. '/projects.json'
local markers = {
  '.git',
  'package.json',
  'go.mod',
  'Cargo.toml',
  'build.zig',
  'Makefile',
  'composer.json',
  'pyproject.toml',
  '.project',
}

local function read_list()
  local ok, f = pcall(io.open, store, 'r')
  if not ok or not f then
    return {}
  end
  local data = f:read '*a'
  f:close()
  local decoded_ok, decoded = pcall(vim.json.decode, data)
  if not decoded_ok or type(decoded) ~= 'table' then
    return {}
  end
  return decoded
end

local function write_list(list)
  local ok, f = pcall(io.open, store, 'w')
  if not ok or not f then
    return
  end
  f:write(vim.json.encode(list))
  f:close()
end

function M.is_project(dir)
  for _, m in ipairs(markers) do
    if vim.fn.isdirectory(dir .. '/' .. m) == 1 or vim.fn.filereadable(dir .. '/' .. m) == 1 then
      return true
    end
  end
  return false
end

local function normalize(dir)
  dir = vim.fn.fnamemodify(dir, ':p')
  if #dir > 1 then
    dir = dir:gsub('/+$', '')
  end
  return dir
end

function M.add(dir)
  dir = normalize(dir or vim.fn.getcwd())
  if vim.fn.isdirectory(dir) == 0 then
    return
  end
  local out = {
    {
      name = vim.fn.fnamemodify(dir, ':t'),
      dir = vim.fn.fnamemodify(dir, ':~'),
      path = dir,
    },
  }
  local seen = { [dir] = true }
  for _, p in ipairs(read_list()) do
    local path = p.path and normalize(p.path)
    if path and not seen[path] then
      seen[path] = true
      out[#out + 1] = {
        name = (p.name ~= nil and p.name ~= '') and p.name or vim.fn.fnamemodify(path, ':t'),
        dir = vim.fn.fnamemodify(path, ':~'),
        path = path,
      }
    end
  end
  write_list(vim.list_slice(out, 1, 20))
end

function M.list()
  local out = {}
  local seen = {}
  for _, p in ipairs(read_list()) do
    local path = p.path and normalize(p.path)
    if path and not seen[path] and vim.fn.isdirectory(path) == 1 then
      seen[path] = true
      out[#out + 1] = {
        name = (p.name ~= nil and p.name ~= '') and p.name or vim.fn.fnamemodify(path, ':t'),
        dir = vim.fn.fnamemodify(path, ':~'),
        path = path,
      }
    end
  end
  return out
end

-- Normal, listed file buffers (terminals and plugin UIs are left alone).
local function file_buffers()
  local out = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if
      vim.api.nvim_buf_is_valid(buf)
      and vim.bo[buf].buflisted
      and vim.bo[buf].buftype == ''
      and vim.api.nvim_buf_get_name(buf) ~= ''
    then
      out[#out + 1] = buf
    end
  end
  return out
end

local function under_root(name, real_root)
  if name == '' then
    return true
  end
  local real = vim.uv.fs_realpath(name) or name
  return real:sub(1, #real_root + 1) == real_root .. '/'
end

-- Sessions are saved with `sessionoptions=buffers`, so older sessions can
-- still list files from other projects. Drop every listed file buffer that
-- lives outside `root` so pickers, the explorer and :bnext stay scoped to
-- the project that is actually open.
function M.prune(root)
  root = normalize(root)
  local real_root = (vim.uv.fs_realpath(root) or root):gsub('/+$', '')
  for _, buf in ipairs(file_buffers()) do
    local name = vim.api.nvim_buf_get_name(buf)
    if not under_root(name, real_root) then
      pcall(vim.api.nvim_buf_delete, buf, { force = true })
    end
  end
end

function M.open(path)
  path = normalize(path)
  if vim.fn.isdirectory(path) == 0 then
    vim.notify('Project no longer exists: ' .. path, vim.log.levels.WARN)
    return
  end

  local bufs = file_buffers()
  local modified = 0
  for _, buf in ipairs(bufs) do
    if vim.bo[buf].modified then
      modified = modified + 1
    end
  end
  if
    modified > 0
    and vim.fn.confirm(('Switch project and discard %d unsaved buffer(s)?'):format(modified), '&Switch\n&Cancel', 2) ~= 1
  then
    return
  end

  local explorer_open = false
  pcall(function()
    explorer_open = require('core.explorer').is_open()
  end)

  -- Close the explorer through neo-tree itself first; tearing windows down
  -- under it leaves a stale state buffer that makes the post-switch re-root
  -- race its debounced navigate (E95: buffer name already exists).
  pcall(function()
    require('neo-tree.command').execute { action = 'close', source = 'filesystem' }
  end)

  -- Keep the current project's layout for when we come back (the save hook
  -- strips neo-tree buffers so sessions never restore them).
  pcall(function()
    require('persistence').save()
  end)

  -- Close the previous project's file buffers so its state doesn't linger.
  vim.cmd('silent! tabonly')
  vim.cmd('silent! only')
  for _, buf in ipairs(bufs) do
    pcall(vim.api.nvim_buf_delete, buf, { force = true })
  end

  M.add(path)
  vim.cmd('cd ' .. vim.fn.fnameescape(path))
  -- persistence keys sessions by cwd, so this restores this project's layout.
  pcall(function()
    require('persistence').load()
  end)

  -- The session restores its own saved cwd and can re-add buffers that were
  -- never pruned when it was written. Re-assert the project root and scrub
  -- anything outside it so the whole editor really moves to the project.
  vim.cmd('cd ' .. vim.fn.fnameescape(path))
  M.prune(path)

  -- The explorer caches its own root (bind_to_cwd = false), so re-root it
  -- explicitly instead of letting it reopen on the previous project. Drop any
  -- orphaned tree buffers first so neo-tree can recreate its own cleanly.
  if explorer_open then
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local name = vim.api.nvim_buf_get_name(buf)
      -- names can carry an absolute-path prefix after a cwd change
      if name:find('neo%-tree ') and #vim.fn.win_findbuf(buf) == 0 then
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end
    end
    pcall(function()
      require('neo-tree.command').execute { action = 'show', source = 'filesystem', dir = path, position = 'right' }
    end)
  end

  vim.notify('Project: ' .. vim.fn.fnamemodify(path, ':t'))
end

function M.pick()
  local items = M.list()
  if vim.tbl_isempty(items) and M.is_project(vim.fn.getcwd()) then
    M.add()
    items = M.list()
  end
  if vim.tbl_isempty(items) then
    vim.notify('No projects yet — open a project directory once', vim.log.levels.WARN)
    return
  end
  vim.ui.select(items, {
    prompt = 'Open project',
    format_item = function(p)
      return string.format('%s  %s', p.name, p.dir)
    end,
  }, function(choice)
    if choice then
      M.open(choice.path)
    end
  end)
end

-- Track whatever project we land in.
vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
  callback = function()
    local cwd = vim.fn.getcwd()
    if M.is_project(cwd) then
      M.add(cwd)
    end
  end,
})

-- Neo-tree's window buffer is a NAMED nofile buffer, so mksession writes it
-- into the session; restoring it later makes neo-tree collide with itself
-- (E95) whenever the cwd differs. Drop those buffers right before saving.
vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('projects.session-clean', { clear = true }),
  pattern = 'PersistenceSavePre',
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local name = vim.api.nvim_buf_get_name(buf)
      if name:find('neo%-tree ') then
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end
    end
  end,
})

vim.keymap.set('n', '<leader>pp', M.pick, { desc = 'Open project' })
vim.keymap.set('n', '<leader>pa', function()
  M.add()
  vim.notify('Added to projects: ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t'))
end, { desc = 'Add current dir to projects' })

return M
