vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.g.scrollbar_v2_notice = false

-- neo-tree is the file explorer; keep netrw from loading (its VimLeave handler
-- was the one erroring after an EMFILE) and raise the open-file limit early.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('core.limits').raise_nofile()

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require 'core.options'
require 'core.keymaps'
require 'core.autocmds'
require 'core.projects'
require 'core.neovide'
require 'core.octo_zdiff'.setup()
require('lazy').setup('plugins', {
  -- No plugin here needs luarocks; disabling it avoids hererocks/luarocks
  -- health errors on fresh machines that have no LuaRocks installed.
  rocks = { enabled = false },
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
