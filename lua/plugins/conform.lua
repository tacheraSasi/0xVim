return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = { 'n', 'x' },
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then return nil end
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettier' }, typescript = { 'prettier' },
      javascriptreact = { 'prettier' }, typescriptreact = { 'prettier' },
      json = { 'prettier' }, yaml = { 'prettier' },
      html = { 'prettier' }, css = { 'prettier' }, scss = { 'prettier' },
      markdown = { 'prettier' },
      python = { 'black' }, go = { 'gofumpt' }, rust = { 'rustfmt' },
      sh = { 'shfmt' }, bash = { 'shfmt' }, zsh = { 'shfmt' },
    },
  },
}
