-- Central error/warning log: everything goes to one file with a timestamp
-- and the current directory so nothing is lost between sessions.
--   :NvimErrors   or   <leader>uE   opens it.
local error_log_path = vim.fn.stdpath('state') .. '/errors.log'

local function rotate_log()
  local stat = (vim.uv or vim.loop).fs_stat(error_log_path)
  if not stat or stat.size < 1024 * 1024 then
    return
  end
  local ok, lines = pcall(vim.fn.readfile, error_log_path)
  if not ok or type(lines) ~= 'table' then
    return
  end
  vim.fn.writefile(vim.list_slice(lines, math.max(1, #lines - 500)), error_log_path)
end

local function append_error(msg)
  if msg == nil or msg == '' then
    return
  end
  if type(msg) ~= 'string' then
    msg = vim.inspect(msg)
  end
  msg = msg:gsub('\n', ' ')
  rotate_log()
  local ok, file = pcall(io.open, error_log_path, 'a')
  if not ok or not file then
    return
  end
  file:write(('%s [%s] %s\n'):format(os.date('%Y-%m-%d %H:%M:%S'), vim.fn.getcwd(), msg))
  file:close()
end

do
  local ok, file = pcall(io.open, error_log_path, 'a')
  if ok and file then
    file:write(('\n===== %s — nvim %s @ %s =====\n'):format(os.date('%Y-%m-%d %H:%M:%S'), tostring(vim.version()), vim.fn.getcwd()))
    file:close()
  end
end

for _, name in ipairs({ 'nvim_err_writeln', 'nvim_err_write' }) do
  local orig = vim.api[name]
  vim.api[name] = function(msg, ...)
    append_error(msg)
    return orig(msg, ...)
  end
end

-- Also capture warnings/errors emitted through vim.notify (plugins, LSP,
-- Omarchy integrations) and deprecations. Note: nvim-notify replaces
-- vim.notify during plugin setup, so the logger is re-installed on VimEnter
-- and after VeryLazy, wrapping whatever implementation won.
local level_tags = {
  [vim.log.levels.WARN] = 'WARN',
  [vim.log.levels.ERROR] = 'ERROR',
}

local function install_notify_logger()
  local current = vim.notify
  if current == _G.__nvim_logged_notify then
    return
  end
  local wrapped = function(msg, level, opts)
    level = level or vim.log.levels.INFO
    local tag = level_tags[level]
    if tag then
      append_error('[' .. tag .. '] ' .. (type(msg) == 'string' and msg or vim.inspect(msg)))
    end
    local ret = current(msg, level, opts)
    -- snacks.notifier swaps vim.notify on first use; re-attach the logger.
    vim.schedule(install_notify_logger)
    return ret
  end
  _G.__nvim_logged_notify = wrapped
  vim.notify = wrapped
end

install_notify_logger()
local log_group = vim.api.nvim_create_augroup('nvim-notify-log', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
  group = log_group,
  once = true,
  callback = function()
    vim.schedule(install_notify_logger)
  end,
})
vim.api.nvim_create_autocmd('User', {
  group = log_group,
  pattern = 'VeryLazy',
  once = true,
  callback = function()
    vim.schedule(install_notify_logger)
  end,
})
-- Safety net: lazy loads startup plugins around VimEnter, after which
-- nvim-notify owns vim.notify. Re-wrap once everything has settled.
vim.defer_fn(install_notify_logger, 500)

local deprecate = vim.deprecate
local logged_deprecations = {}

-- Calls originating inside a lazy.nvim package are third-party plugin
-- deprecations we cannot patch here. Record them once in errors.log, but do
-- not forward them (keeps :checkhealth vim.deprecated and toast popups clean).
local function from_plugin()
  for level = 2, 12 do
    local info = debug.getinfo(level, 'S')
    if not info then
      return false
    end
    if info.source and info.source:find('/lazy/', 1, true) then
      return true
    end
  end
  return false
end

vim.deprecate = function(name, alternative, version, plugin, backtrace)
  local key = tostring(name) .. '->' .. tostring(alternative)
  if not logged_deprecations[key] then
    logged_deprecations[key] = true
    append_error(('[DEPRECATED] %s -> %s'):format(tostring(name), tostring(alternative)))
  end
  if plugin or from_plugin() then
    return
  end
  return deprecate(name, alternative, version, plugin, backtrace)
end

vim.api.nvim_create_user_command('NvimErrors', function()
  vim.cmd('edit ' .. vim.fn.fnameescape(error_log_path))
  vim.cmd('normal! G')
end, { desc = 'Open the Neovim error/warning log' })

vim.keymap.set('n', '<leader>uE', '<cmd>NvimErrors<cr>', { desc = 'Open nvim error log' })

-- Async plugins (laravel.nvim, linters, LSP helpers) sometimes call
-- vim.diagnostic.set for a buffer that was deleted while their task was
-- running — nvim throws "Invalid buffer id" inside a coroutine. Ignore
-- diagnostics aimed at buffers that no longer exist instead of crashing.
local diagnostic_set = vim.diagnostic.set
vim.diagnostic.set = function(namespace, bufnr, diagnostics, opts)
  if type(bufnr) == 'number' and bufnr ~= 0 and not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end
  return diagnostic_set(namespace, bufnr, diagnostics, opts)
end

local augroup = vim.api.nvim_create_augroup('nvim-general', { clear = true })

-- Laravel Blade templates: *.blade.php
vim.filetype.add({ pattern = { ['.*%.blade%.php'] = 'blade' } })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = augroup,
  callback = function()
    -- nvim 0.13 renamed on_yank -> hl_op
    local hl_op = vim.hl.hl_op or vim.hl.on_yank
    hl_op()
  end,
})

-- Heavy-file mode: on very large buffers, turn off the animated smooth
-- scroll — animating every wheel tick while everything else redraws causes
-- visible flicker/glitching.
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Disable smooth scroll on very large files',
  group = augroup,
  callback = function(args)
    if vim.api.nvim_buf_line_count(args.buf) > 300 then
      vim.b[args.buf].snacks_scroll = false
      -- mousemoveevent is a global option, so only lower it while a heavy
      -- buffer is focused and restore it on the next buffer/window switch.
      vim.b[args.buf].heavy_file = true
      vim.o.mousemoveevent = false
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
  desc = 'Scope mousemoveevent to heavy buffers',
  group = augroup,
  callback = function()
    vim.o.mousemoveevent = not vim.b[vim.api.nvim_get_current_buf()].heavy_file
  end,
})

-- Auto-create missing parent directories when saving a new file.
-- Fixes E212: Can't open file for writing (e.g. :e newdir/file.go | :w).
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Create parent dirs on write',
  group = augroup,
  callback = function(event)
    local file = event.match or vim.api.nvim_buf_get_name(0)
    if file == '' then return end
    local dir = vim.fn.fnamemodify(file, ':h')
    if dir == '' or dir == '.' then return end
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
      vim.notify('Created directory: ' .. dir, vim.log.levels.INFO)
    end
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup,
  callback = function(event)
    local bufnr = event.buf
    if vim.b[bufnr]._organize_imports_attached then
      return
    end
    vim.b[bufnr]._organize_imports_attached = true
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      group = augroup,
      callback = function(args)
        local buf = args.buf
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end
        -- Build the request for the buffer being written, not the window's
        -- current buffer: BufWritePre also fires for background writes (:wa,
        -- autosave) and must not organize imports in some other file.
        local params = {
          textDocument = { uri = vim.uri_from_bufnr(buf) },
          range = {
            start = { line = 0, character = 0 },
            ['end'] = { line = vim.api.nvim_buf_line_count(buf), character = 0 },
          },
          context = { only = { 'source.organizeImports' }, diagnostics = {} },
        }
        local results = vim.lsp.buf_request_sync(buf, 'textDocument/codeAction', params, 1000)
        for client_id, res in pairs(results or {}) do
          local rclient = vim.lsp.get_client_by_id(client_id)
          local enc = (rclient and rclient.offset_encoding) or 'utf-16'
          for _, action in pairs(res.result or {}) do
            if action.edit then
              vim.lsp.util.apply_workspace_edit(action.edit, enc)
            end
          end
        end
      end,
    })
  end,
})

-- Track the last real editor window so the explorer toggle can restore focus.
local explorer_augroup = vim.api.nvim_create_augroup('nvim-explorer-focus', { clear = true })
local last_editor_win = nil
_G.__nvim_last_editor_win = function() return last_editor_win end

local function is_editor_win(win)
  local buf = vim.api.nvim_win_get_buf(win)
  local ft = vim.bo[buf].filetype
  local bt = vim.bo[buf].buftype
  return ft ~= 'neo-tree'
    and ft ~= 'toggleterm'
    and ft ~= 'TelescopePrompt'
    and ft ~= 'Trouble'
    and ft ~= 'zdiff'
    and bt ~= 'nofile'
    and bt ~= 'terminal'
    and bt ~= 'prompt'
end

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = explorer_augroup,
  callback = function()
    local win = vim.api.nvim_get_current_win()
    if is_editor_win(win) then
      last_editor_win = win
    end
  end,
})

-- Large files -----------------------------------------------------------------
-- Big files lag while scrolling in both terminal Neovim and Neovide. Detect
-- them and turn off the expensive per-line features.
local large_file_augroup = vim.api.nvim_create_augroup('nvim-large-files', { clear = true })
local LARGE_FILE_BYTES = 200 * 1024 -- 200 KB

function _G.is_large_file(bufnr)
  bufnr = (bufnr == nil or bufnr == 0) and vim.api.nvim_get_current_buf() or bufnr
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == '' then
    return false
  end
  local ok, stats = pcall((vim.uv or vim.loop).fs_stat, name)
  return ok and stats ~= nil and stats.size > LARGE_FILE_BYTES
end

vim.api.nvim_create_autocmd({ 'BufReadPre', 'FileReadPre' }, {
  group = large_file_augroup,
  callback = function(args)
    if not _G.is_large_file(args.buf) then
      return
    end
    vim.b[args.buf].large_file = true
    vim.opt_local.syntax = 'off'
    vim.opt_local.foldmethod = 'manual'
    vim.opt_local.foldenable = false
    vim.opt_local.spell = false
    vim.opt_local.list = false
    vim.opt_local.swapfile = false
    vim.opt_local.undofile = false
    vim.opt_local.signcolumn = 'no'
  end,
})

-- Treesitter is the biggest scrolling bottleneck on huge files. The plugin
-- starts it on FileType, so stop it right after that has run.
vim.api.nvim_create_autocmd('FileType', {
  group = large_file_augroup,
  callback = function(args)
    if not _G.is_large_file(args.buf) then
      return
    end
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        pcall(vim.treesitter.stop, args.buf)
      end
    end)
  end,
})
