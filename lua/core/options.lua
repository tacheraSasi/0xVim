vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Make Mason-installed binaries (formatters, linters, debug adapters,
-- Go tools) resolvable from Neovim.
vim.env.PATH = vim.fn.stdpath('data') .. '/mason/bin:' .. vim.env.PATH
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
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
