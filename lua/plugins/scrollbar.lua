return {
  'petertriho/nvim-scrollbar',
  event = 'BufReadPost',
  dependencies = { 'kevinhwang91/nvim-hlslens' },
  opts = {
    show_in_active_only = false,
    handle = { blend = 30 },
    marks = {
      Cursor = { text = '•' },
      Search = { priority = 1, text = '≡' },
      Error = { priority = 2 },
      Warn = { priority = 2 },
      Info = { priority = 2 },
      Hint = { priority = 2 },
      GitAdd = { text = '┃' },
      GitChange = { text = '┃' },
      GitDelete = { text = '┃' },
    },
    excluded_filetypes = {
      'neo-tree', 'telescope', 'dashboard', 'lazy', 'mason', 'checkhealth',
      'noice', 'codewindow', 'codediff-explorer', 'codediff-history',
      'spectre', 'toggleterm', 'prompt', 'qf', 'help',
    },
  },
  config = function(_, opts)
    require('hlslens').setup()
    require('scrollbar').setup(opts)
    require('scrollbar.handlers.search').setup { override_lsp = true }
  end,
}