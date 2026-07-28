vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to upper window' })

vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result centered' })

vim.keymap.set('n', '<leader>w', '<C-w>', { desc = 'Window operations' })
vim.keymap.set('n', '<leader>ww', '<C-w>w', { desc = 'Next window' })
vim.keymap.set('n', '<leader>wd', '<C-w>c', { desc = 'Delete window' })
vim.keymap.set('n', '<leader>w-', '<C-w>s', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>w|', '<C-w>v', { desc = 'Split window vertically' })

vim.keymap.set('n', '<leader>bn', ':bn<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', ':bp<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Delete buffer' })

require('core.vscode-keybindings')
