return {
  'mbbill/undotree',
  cmd = 'UndotreeToggle',
  keys = {
    { '<leader>uu', '<cmd>UndotreeToggle<CR>', desc = 'Undo tree' },
  },
  init = function()
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_SplitWidth = 32
  end,
}
