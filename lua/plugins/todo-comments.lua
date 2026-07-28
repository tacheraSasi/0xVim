return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = true },
  keys = {
    { '<leader>xt', '<cmd>TodoTrouble<cr>', desc = 'Todo (Trouble)' },
    { '<leader>xT', '<cmd>TodoTelescope<cr>', desc = 'Todo (Telescope)' },
  },
}
