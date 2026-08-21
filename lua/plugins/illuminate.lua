return {
  'RRethy/vim-illuminate',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = { providers = { 'lsp' } },
    under_cursor = true,
    filetypes_denylist = {
      'neo-tree', 'telescope', 'noice', 'dashboard', 'lazy', 'mason',
      'checkhealth', 'codewindow', 'codediff-explorer', 'codediff-history',
      'spectre', 'help', 'qf', 'prompt', 'toggleterm',
    },
  },
  config = function(_, opts)
    require('illuminate').configure(opts)
  end,
}