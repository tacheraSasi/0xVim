local augroup = vim.api.nvim_create_augroup('nvim-general', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = augroup,
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup,
  callback = function(event)
    local bufnr = event.buf
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      group = augroup,
      callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { 'source.organizeImports' }, diagnostics = {} }
        local results = vim.lsp.buf_request_sync(bufnr, 'textDocument/codeAction', params, 1000)
        for _, res in pairs(results or {}) do
          for _, action in pairs(res.result or {}) do
            if action.edit then
              vim.lsp.util.apply_workspace_edit(action.edit, 'utf-16')
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
