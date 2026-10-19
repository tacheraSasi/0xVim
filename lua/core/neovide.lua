-- Neovide-specific tuning. Only runs inside Neovide.
if not vim.g.neovide then
  return
end

-- Start from a clean 1.0 scale. Zooming is handled in
-- core/vscode-keybindings.lua by changing this factor instead of guifont:
-- resizing the font makes Neovide re-render glyphs with different
-- hinting/spacing, so the font visibly "changes" as you zoom.
vim.g.neovide_scale_factor = 1.0

-- Animations. The default scroll/cursor animations are what make long buffers
-- feel like they "stick" on this machine, so keep them very short.
vim.g.neovide_scroll_animation_length = 0.1
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_trail_size = 0.1

-- Performance.
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_confirm_quit = false

-- Opacity: 1.0 = fully opaque. Transparency costs frame time, so keep it off.
-- (Neovide 0.16 renamed neovide_transparency -> neovide_opacity.)
vim.g.neovide_opacity = 1.0
