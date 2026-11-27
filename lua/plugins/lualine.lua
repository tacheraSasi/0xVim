-- Transparent status line: show the terminal background, like the rest of
-- the editor. Lualine's auto theme paints its middle sections a solid
-- colour, so the b/c sections are cleared on each theme build (this runs
-- again on every colorscheme change). Mode and position sections keep
-- their colours.
--
-- This lives in lualine.lua's config (this file previously existed as a
-- separate `lualine-transparent.lua` spec whose opts were silently
-- ignored — see issue #22).
local function transparent_theme()
  local theme = require('lualine.utils.loader').load_theme('auto')
  for _, mode in pairs(theme) do
    for _, section in ipairs({ 'b', 'c' }) do
      if mode[section] then
        mode[section].bg = 'None'
      end
    end
  end
  return theme
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
  config = function()
    local navic = require('nvim-navic')
    require('lualine').setup {
      options = { theme = transparent_theme, component_separators = { left = '', right = '' }, section_separators = { left = '', right = '' } },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          { 'filename', path = 1 },
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    }
  end,
}
