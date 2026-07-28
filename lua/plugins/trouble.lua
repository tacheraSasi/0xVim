return {
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
}
