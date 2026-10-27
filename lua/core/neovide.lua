-- Neovide-specific tuning. Only runs inside Neovide.
if not vim.g.neovide then
  return
end

-- Start at zoom 1.2. Zooming is handled in
-- core/vscode-keybindings.lua by changing this factor instead of guifont:
-- resizing the font makes Neovide re-render glyphs with different
-- hinting/spacing, so the font visibly "changes" as you zoom.
vim.g.neovide_scale_factor = 1.2

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

-- Inline images (snacks.image) need the Kitty graphics protocol, which
-- Neovide does not implement. Instead of showing an unsupported-terminal
-- placeholder, open images/videos with the system default app (imv for
-- pictures, VLC for video). In Ghostty, snacks.image renders inline natively.
vim.api.nvim_create_autocmd('BufReadCmd', {
  group = vim.api.nvim_create_augroup('neovide.external-images', { clear = true }),
  pattern = '*.png,*.jpg,*.jpeg,*.gif,*.bmp,*.webp,*.tiff,*.heic,*.avif,*.icns,*.pdf,*.mp4,*.mov,*.avi,*.mkv,*.webm',
  callback = function(ev)
    vim.ui.open(ev.match)
    local buf = ev.buf
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end)
  end,
})
