-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Better indentation
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })

-- Move lines up and down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line down' })
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv', { desc = 'Move line down' })
vim.keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv', { desc = 'Move line up' })

-- Better search
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result' })

-- Better window management
vim.keymap.set('n', '<leader>w', '<C-w>', { desc = 'Window operations' })
vim.keymap.set('n', '<leader>ww', '<C-w>w', { desc = 'Next window' })
vim.keymap.set('n', '<leader>wd', '<C-w>c', { desc = 'Delete window' })
vim.keymap.set('n', '<leader>w-', '<C-w>s', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>w|', '<C-w>v', { desc = 'Split window vertically' })

-- Better buffer management
vim.keymap.set('n', '<leader>bn', ':bn<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', ':bp<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Delete buffer' })

-- Additional settings
vim.opt.wrap = false -- Disable line wrapping
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt.smartindent = true -- Do smart autoindenting when starting a new line
vim.opt.termguicolors = true -- Enable true color support
vim.opt.hidden = true -- Hide buffers instead of closing them
vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false -- Disable backup files
vim.opt.writebackup = false -- Disable write backup
vim.opt.undodir = vim.fn.stdpath('data') .. '/undodir' -- Set undo directory
vim.opt.undofile = true -- Enable persistent undo
vim.opt.incsearch = true -- Show search matches as you type
vim.opt.hlsearch = true -- Highlight search matches
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override ignorecase if search pattern contains uppercase
vim.opt.completeopt = 'menuone,noselect' -- Better completion experience
vim.opt.wildmode = 'longest:full,full' -- Better command-line completion
vim.opt.wildmenu = true -- Enable wildmenu
vim.opt.wildignore = '*.o,*.obj,*.dylib,*.bin,*.dll,*.so,*.pyc,*.jpg,*.png,*.gif,*.zip,*.tar.gz,*.tar.bz2,*.tar.xz,*.tar' -- Ignore these files in wildmenu

-- Load completion configuration
require('custom.cmp') 