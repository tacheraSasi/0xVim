return {
  'mfussenegger/nvim-lint',
  event = { 'BufWritePost', 'InsertLeave' },
  config = function()
    local lint = require('lint')
    lint.linters_by_ft = {
      php = { 'phpstan', 'phpcs' },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      vue = { 'eslint_d' },
      go = { 'golangcilint' },
      python = { 'ruff', 'flake8' },
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
      zsh = { 'shellcheck' },
      lua = { 'luacheck' },
      yaml = { 'yamllint' },
      markdown = { 'markdownlint-cli2' },
    }
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
      callback = function()
        pcall(require('lint').try_lint)
      end,
    })
  end,
}