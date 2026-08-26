return {
  'petertriho/nvim-scrollbar',
  event = 'BufReadPost',
  dependencies = { 'kevinhwang91/nvim-hlslens' },
  opts = {
    show_in_active_only = false,
    handle = { blend = 30 },
    -- Skip rendering entirely on huge buffers (redraw flicker while scrolling)
    max_lines = 5000,
    marks = {
      Cursor = { text = '•' },
      Search = { priority = 1, text = { '≡' } },
      Error = { priority = 2, text = { '-', '=' } },
      Warn = { priority = 2, text = { '-', '=' } },
      Info = { priority = 2, text = { '-', '=' } },
      Hint = { priority = 2, text = { '-', '=' } },
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