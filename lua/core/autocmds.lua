-- Error log: record every runtime error with a timestamp and the current
-- directory so nothing is lost between sessions.
local error_log_path = vim.fn.stdpath('state') .. '/errors.log'
local function append_error(msg)
  if msg == nil or msg == '' then return end
  local ok, file = pcall(io.open, error_log_path, 'a')
  if not ok or not file then return end
  file:write(('%s [%s] %s\n'):format(os.date('%Y-%m-%d %H:%M:%S'), vim.fn.getcwd(), msg))
  file:close()
end

for _, name in ipairs({ 'nvim_err_writeln', 'nvim_err_write' }) do
  local orig = vim.api[name]
  vim.api[name] = function(msg, ...)
    append_error(msg)
    return orig(msg, ...)
  end
end

local augroup = vim.api.nvim_create_augroup('nvim-general', { clear = true })

-- Laravel Blade templates: *.blade.php
vim.filetype.add({ pattern = { ['.*%.blade%.php'] = 'blade' } })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = augroup,
  callback = function()
    vim.hl.on_yank()
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
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local offset_encoding = (client and client.offset_encoding) or 'utf-16'
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      group = augroup,
      callback = function()
        local params = vim.lsp.util.make_range_params(0, offset_encoding)
        params.context = { only = { 'source.organizeImports' }, diagnostics = {} }
        local results = vim.lsp.buf_request_sync(bufnr, 'textDocument/codeAction', params, 1000)
        for _, res in pairs(results or {}) do
          for _, action in pairs(res.result or {}) do
            if action.edit then
              vim.lsp.util.apply_workspace_edit(action.edit, offset_encoding)
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
