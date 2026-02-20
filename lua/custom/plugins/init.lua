--- Theme management and switching utilities for 0xVim
--- Provides functions to switch between various color schemes
--- and update lualine theme accordingly
--- @module theme-manager

local M = {}

--- Available themes with their lualine equivalents
--- @type table<string, string>
local themes = {
  ['vscode'] = 'vscode',
  ['tokyonight-night'] = 'tokyonight',
  ['tokyonight-storm'] = 'tokyonight',
  ['tokyonight-moon'] = 'tokyonight',
  ['tokyonight-day'] = 'tokyonight',
  ['catppuccin'] = 'catppuccin',
  ['catppuccin-latte'] = 'catppuccin-latte',
  ['catppuccin-frappe'] = 'catppuccin-frappe',
  ['catppuccin-macchiato'] = 'catppuccin-macchiato',
  ['catppuccin-mocha'] = 'catppuccin-mocha',
  ['dracula'] = 'dracula',
  ['nord'] = 'nord',
  ['gruvbox'] = 'gruvbox',
  ['onedark'] = 'onedark',
  ['kanagawa'] = 'kanagawa',
  ['nightfox'] = 'nightfox',
  ['rose-pine'] = 'rose-pine',
  ['material'] = 'material',
}

--- Switch to a specific theme and update lualine
--- @param theme_name string The name of the theme to switch to
--- @return boolean success Whether the theme switch was successful
function M.switch_theme(theme_name)
  -- Check if theme exists
  if not themes[theme_name] then
    print(string.format('Theme "%s" not found. Available themes: %s', 
      theme_name, 
      table.concat(vim.tbl_keys(themes), ', ')))
    return false
  end

  -- Try to load the colorscheme
  local ok = pcall(vim.cmd.colorscheme, theme_name)
  if not ok then
    print(string.format('Failed to load theme "%s". Make sure the plugin is installed.', theme_name))
    return false
  end

  -- Update lualine theme if available
  local lualine_ok, lualine = pcall(require, 'lualine')
  if lualine_ok then
    local lualine_theme = themes[theme_name]
    lualine.setup({
      options = {
        theme = lualine_theme,
      }
    })
  end

  print(string.format('Switched to theme: %s', theme_name))
  return true
end

--- Switch to original theme (tokyonight-night)
function M.switch_to_original_theme()
  M.switch_theme('tokyonight-night')
end

--- Switch to VSCode theme
function M.switch_to_vscode_theme()
  M.switch_theme('vscode')
end

--- Switch to Catppuccin Mocha theme
function M.switch_to_catppuccin_theme()
  M.switch_theme('catppuccin-mocha')
end

--- Switch to Dracula theme
function M.switch_to_dracula_theme()
  M.switch_theme('dracula')
end

--- Switch to Nord theme
function M.switch_to_nord_theme()
  M.switch_theme('nord')
end

--- Switch to Gruvbox theme
function M.switch_to_gruvbox_theme()
  M.switch_theme('gruvbox')
end

--- Show theme picker using Telescope
function M.theme_picker()
  local ok, builtin = pcall(require, 'telescope.builtin')
  if ok then
    builtin.colorscheme({ enable_preview = true })
  else
    print('Telescope not available')
  end
end

-- Create keymaps to switch themes
vim.keymap.set('n', '<leader>to', M.switch_to_original_theme, { desc = 'Switch to [O]riginal theme (Tokyo Night)' })
vim.keymap.set('n', '<leader>tv', M.switch_to_vscode_theme, { desc = 'Switch to [V]SCode theme' })
vim.keymap.set('n', '<leader>tc', M.switch_to_catppuccin_theme, { desc = 'Switch to [C]atppuccin theme' })
vim.keymap.set('n', '<leader>td', M.switch_to_dracula_theme, { desc = 'Switch to [D]racula theme' })
vim.keymap.set('n', '<leader>tn', M.switch_to_nord_theme, { desc = 'Switch to [N]ord theme' })
vim.keymap.set('n', '<leader>tg', M.switch_to_gruvbox_theme, { desc = 'Switch to [G]ruvbox theme' })
vim.keymap.set('n', '<leader>tt', M.theme_picker, { desc = 'Open [T]heme picker' })

return {}

