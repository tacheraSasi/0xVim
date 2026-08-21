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
    format_on_save = function()
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
    formatters_by_ft = {
      -- C / C++
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      -- Lua
      lua = { 'stylua' },
      -- JavaScript / TypeScript / React / React Native / NestJS
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      -- JSON / YAML / HTML / CSS
      json = { 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      css = { 'prettierd', 'prettier', stop_after_first = true },
      scss = { 'prettierd', 'prettier', stop_after_first = true },
      less = { 'prettierd', 'prettier', stop_after_first = true },
      -- Markdown
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
      ['markdown.mdx'] = { 'prettierd', 'prettier', stop_after_first = true },
      -- Python
      python = { 'isort', 'black' },
      -- Go (gofumpt + goimports; golines for long lines)
      go = { 'goimports', 'gofumpt' },
      -- Rust
      rust = { 'rustfmt' },
      -- Zig (uses the system zig binary via zls, not Mason)
      zig = { lsp_format = 'fallback' },
      -- PHP / Laravel / Blade
      php = { 'php-cs-fixer' },
      blade = { 'blade-formatter', 'prettierd', stop_after_first = true },
      -- Shell
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      zsh = { 'shfmt' },
      -- Vue / Svelte
      vue = { 'prettierd', 'prettier', stop_after_first = true },
      svelte = { 'prettierd', 'prettier', stop_after_first = true },
      -- Prisma
      prisma = { 'prisma-format' },
      -- GraphQL
      graphql = { 'prettierd', 'prettier', stop_after_first = true },
    },
    formatters = {
      zigfmt = {
        command = 'zig',
        args = { 'fmt', '--stdin' },
        stdin = true,
      },
    },
  },
}
