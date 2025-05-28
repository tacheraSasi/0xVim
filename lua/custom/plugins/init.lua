-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Add a function to switch between themes
local M = {}

-- Function to switch to the original theme (tokyonight-night)
function M.switch_to_original_theme()
  vim.cmd.colorscheme('tokyonight-night')
  -- Also update lualine theme if it's being used
  local ok, lualine = pcall(require, 'lualine')
  if ok then
    lualine.setup({
      options = {
        theme = 'tokyonight',
      }
    })
  end
  print("Switched to original theme (tokyonight-night)")
end

-- Function to switch to the VSCode theme
function M.switch_to_vscode_theme()
  vim.cmd.colorscheme('vscode')
  -- Also update lualine theme if it's being used
  local ok, lualine = pcall(require, 'lualine')
  if ok then
    lualine.setup({
      options = {
        theme = 'vscode',
      }
    })
  end
  print("Switched to VSCode theme")
end

-- Create keymaps to switch themes
vim.keymap.set('n', '<leader>to', M.switch_to_original_theme, { desc = 'Switch to [O]riginal theme' })
vim.keymap.set('n', '<leader>tv', M.switch_to_vscode_theme, { desc = 'Switch to [V]SCode theme' })

return {}
