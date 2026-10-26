return {
  'pwntester/octo.nvim',
  cmd = 'Octo',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    picker = 'telescope',
    enable_builtin = true,
  },
  keys = {
    -- gP, not gp: <leader>gp is taken by Neogit push (plugins/extra.lua)
    { '<leader>gP', '<cmd>Octo pr list<CR>', desc = 'Octo: pull requests' },
    { '<leader>gi', '<cmd>Octo issue list<CR>', desc = 'Octo: issues' },
    { '<leader>go', '<cmd>Octo<CR>', desc = 'Octo: repo menu' },
  },
}
