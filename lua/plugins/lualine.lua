return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
  config = function()
    local navic = require('nvim-navic')
    require('lualine').setup {
      options = { theme = 'auto', component_separators = { left = '', right = '' }, section_separators = { left = '', right = '' } },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          { 'filename', path = 1 },
          { navic.get_location, cond = navic.is_available },
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    }
  end,
}
