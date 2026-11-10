vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
-- Single global statusline pinned to the bottom of the screen; windows
-- (including the explorer) span the full height instead of each drawing
-- their own status bar.
vim.o.laststatus = 3
vim.o.showmode = false
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Make local toolchain + Mason binaries resolvable from Neovim.
--
-- GUI launches (Neovide, Zed, Finder) do not inherit the shell PATH, so
-- `rg`/`fd`/`git`/`node` can be missing even though they are installed. Add
-- the standard local prefixes explicitly, then Mason's bin directory.
local local_bins = {
  '~/.local/bin',
  '~/.local/opt/node/bin',
  '~/.local/opt/go/bin',
  '~/.zvm/bin',
}
local prefix = {}
for _, dir in ipairs(local_bins) do
  local path = vim.fn.expand(dir)
  if vim.fn.isdirectory(path) == 1 then
    prefix[#prefix + 1] = path
  end
end
vim.env.PATH = table.concat(prefix, ':') .. ':' .. (vim.env.PATH or '')
vim.env.PATH = vim.fn.stdpath('data') .. '/mason/bin:' .. vim.env.PATH
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
-- Skip syntax highlighting on absurdly long lines: a big win when scrolling
-- large/minified files (see core/autocmds.lua for the large-file handling).
vim.o.synmaxcol = 300
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
-- Jumping to a file reuses the last window instead of splitting/failing
vim.o.switchbuf = 'uselast'
vim.o.list = true
vim.opt.listchars = { tab = '│ ', trail = '·', nbsp = '␣', extends = '›', precedes = '‹', space = '·' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.wrap = false
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.smartindent = true
vim.o.termguicolors = true
vim.o.hidden = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.opt.undodir = vim.fn.stdpath('data') .. '/undodir'
vim.o.incsearch = true
vim.o.hlsearch = true
vim.opt.completeopt = 'menuone,noselect'
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildmenu = true
vim.opt.wildignore = '*.o,*.obj,*.dylib,*.bin,*.dll,*.so,*.pyc,*.jpg,*.png,*.gif,*.zip,*.tar.gz,*.tar.bz2,*.tar.xz,*.tar'

-- Zed/VSCode-like editing feel
vim.o.smoothscroll = true
vim.o.splitkeep = 'cursor'
vim.o.winblend = 0
vim.o.pumblend = 0
vim.o.pumheight = 20
vim.o.mousemoveevent = true
vim.o.mousescroll = 'ver:1,hor:1'
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevelstart = 99
vim.o.foldcolumn = '0'
vim.opt.fillchars = {
  eob = ' ',
  fold = ' ',
  foldopen = '',
  foldclose = '',
  foldsep = ' ',
  diff = '╱',
  horiz = '─',
  vert = '│',
  msgsep = '─',
}
if vim.fn.has('macunix') == 1 then
  vim.g.is_mac = true
end
