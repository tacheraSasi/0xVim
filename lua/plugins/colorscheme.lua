-- Colorschemes: one plugin per Omarchy theme, plus automatic follow.
--
-- Omarchy writes the active theme's Neovim spec to
--   ~/.local/state/omarchy/current/theme/neovim.lua
-- on every theme change (including Darky's light/dark switching), so we read the
-- colorscheme name from there and apply it at startup.
local function omarchy_colorscheme()
  local path = vim.fn.expand '~/.local/state/omarchy/current/theme/neovim.lua'
  if vim.fn.filereadable(path) == 0 then
    return nil
  end
  local ok, spec = pcall(dofile, path)
  if not ok or type(spec) ~= 'table' then
    return nil
  end
  for _, s in ipairs(spec) do
    if type(s) == 'table' and type(s.opts) == 'table' and s.opts.colorscheme then
      return s.opts.colorscheme
    end
  end
  return nil
end

local function apply_omarchy_theme()
  local name = omarchy_colorscheme()
  if not name then
    return
  end
  if pcall(vim.cmd.colorscheme, name) then
    vim.g.omarchy_colorscheme = name
  else
    vim.notify('No Neovim colorscheme for Omarchy theme: ' .. name, vim.log.levels.WARN)
  end
end

-- The themes Omarchy ships, matched to their Neovim colorscheme plugin.
-- (Names are the `colorscheme` value Omarchy writes per theme.)
local themes = {
  { 'catppuccin/nvim', name = 'catppuccin' },
  { 'neanias/everforest-nvim' },
  { 'kepano/flexoki-neovim' },
  { 'ellisonleao/gruvbox.nvim' },
  -- hackerman's colorscheme requires the `aether` module.
  { 'bjarneo/hackerman.nvim', deps = { 'bjarneo/aether.nvim' } },
  { 'rebelot/kanagawa.nvim' },
  { 'omacom-io/lumon.nvim' },
  { 'tahayvr/matteblack.nvim' },
  { 'EdenEast/nightfox.nvim' },
  { 'ribru17/bamboo.nvim' },
  { 'OldJobobo/retro-82.nvim' },
  { 'rose-pine/neovim' },
  { 'ficcdaf/ashen.nvim' },
  { 'folke/tokyonight.nvim' },
  -- Extras you already had, not tied to an Omarchy theme.
  { 'Mofiqul/vscode.nvim' },
  { 'Mofiqul/dracula.nvim' },
  { 'navarasu/onedark.nvim' },
  { 'marko-cerovac/material.nvim' },
}

local specs = {}
for _, t in ipairs(themes) do
  specs[#specs + 1] = {
    t[1],
    name = t.name,
    priority = 1000,
    dependencies = t.deps,
  }
end

-- Follow the Omarchy theme once lazy has loaded everything.
specs[#specs + 1] = {
  dir = vim.fn.stdpath 'config',
  name = 'theme-utils',
  lazy = false,
  config = function()
    -- Apply the Omarchy theme as soon as this spec loads. `:colorscheme` makes
    -- lazy.nvim load the providing plugin on demand, so there is nothing to
    -- wait for (VeryLazy only fires with a UI, and an autocmd registered during
    -- VimEnter never fires for that same event).
    vim.schedule(apply_omarchy_theme)
    vim.api.nvim_create_autocmd('User', { pattern = 'VeryLazy', once = true, callback = apply_omarchy_theme })

    vim.keymap.set('n', '<leader>tt', function()
      require('telescope.builtin').colorscheme { enable_preview = true }
    end, { desc = 'Theme picker' })

    vim.keymap.set('n', '<leader>tr', function()
      apply_omarchy_theme()
      vim.notify('Omarchy theme: ' .. (vim.g.omarchy_colorscheme or '?'))
    end, { desc = 'Reload Omarchy theme' })
  end,
}

return specs
