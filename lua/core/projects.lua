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

function M.open(path)
  path = normalize(path)
  if vim.fn.isdirectory(path) == 0 then
    vim.notify('Project no longer exists: ' .. path, vim.log.levels.WARN)
    return
  end
  M.add(path)
  vim.cmd('cd ' .. vim.fn.fnameescape(path))
  -- persistence keys sessions by cwd, so this restores this project's layout.
  pcall(function()
    require('persistence').load()
  end)
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

vim.keymap.set('n', '<leader>pp', M.pick, { desc = 'Open project' })
vim.keymap.set('n', '<leader>pa', function()
  M.add()
  vim.notify('Added to projects: ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t'))
end, { desc = 'Add current dir to projects' })

return M
