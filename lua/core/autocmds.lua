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
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then return end
    local supports_organize = vim.tbl_contains(client.server_capabilities.codeActionProvider or {}, 'source.organizeImports')
      or (client.server_capabilities.codeActionProvider == true)
    if not supports_organize then return end
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
              vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding or 'utf-16')
            end
          end
        end
      end,
    })
  end,
})
