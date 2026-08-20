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

-- Smart buffer close: if it's the last real buffer, open a new empty one
-- (or Dashboard) instead of quitting Neovim entirely.
local function smart_buffer_close()
  local bufnr = vim.api.nvim_get_current_buf()
  local buftype = vim.bo[bufnr].buftype
  -- Don't intercept special buffers (neo-tree, terminal, etc.)
  if buftype ~= '' then
    vim.cmd('bd! ' .. bufnr)
    return
  end
  -- Count real (normal) buffers
  local real_buffers = 0
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buftype == '' and vim.bo[b].filetype ~= '' then
      real_buffers = real_buffers + 1
    end
  end
  if real_buffers <= 1 then
    -- Last real buffer: delete it, then show dashboard or new empty buffer
    vim.cmd('bd ' .. bufnr)
    local ok = pcall(vim.cmd, 'Dashboard')
    if not ok then
      vim.cmd('enew')
    end
  else
    -- Not the last: try to jump to previous buffer before deleting
    local prev_buf = vim.fn.bufnr('#')
    if prev_buf > 0 and vim.api.nvim_buf_is_loaded(prev_buf) and prev_buf ~= bufnr then
      vim.cmd('buffer ' .. prev_buf)
      vim.cmd('bd ' .. bufnr)
    else
      vim.cmd('bd ' .. bufnr)
    end
  end
end

vim.keymap.set('n', '<leader>bd', smart_buffer_close, { desc = 'Delete buffer (smart)' })

require('core.vscode-keybindings')
