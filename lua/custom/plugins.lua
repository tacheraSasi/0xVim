return {
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Toggle Trouble' },
      { '<leader>xw', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Workspace Diagnostics' },
      { '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Document Diagnostics' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List' },
      { '<leader>xl', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List' },
      { 'gR', '<cmd>Trouble lsp_references toggle<cr>', desc = 'LSP References' },
    },
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = true },
    keys = {
      { '<leader>xt', '<cmd>TodoTrouble<cr>', desc = 'Todo (Trouble)' },
      { '<leader>xT', '<cmd>TodoTelescope<cr>', desc = 'Todo (Telescope)' },
    },
  },
  -- NOTE: which-key, telescope, and treesitter are configured in init.lua
  -- NOTE: Completion is handled by blink.cmp in init.lua
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
    },
  },
  {
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',
    dependencies = { 'rafamadriz/friendly-snippets' },
  },
  {
    'onsails/lspkind.nvim',
    config = function()
      require('lspkind').init({ mode = 'symbol', preset = 'codicons' })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' },
  },
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup({ ui = { border = 'rounded' } })
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'ts_ls', 'gopls', 'pyright', 'rust_analyzer', 'jdtls',
          'lua_ls', 'html', 'cssls', 'jsonls', 'yamlls', 'bashls', 'clangd', 'zls',
        },
        automatic_installation = true,
      })
    end,
  },
}
