-- VSCode-like keybindings for Neovim
-- This file implements comprehensive VSCode keyboard shortcuts

-- File operations
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { desc = 'Save file (insert mode)' })
vim.keymap.set('n', '<C-S-s>', ':wa<CR>', { desc = 'Save all files' })

-- Undo/Redo
vim.keymap.set('n', '<C-z>', 'u', { desc = 'Undo' })
vim.keymap.set('i', '<C-z>', '<Esc>ua', { desc = 'Undo (insert mode)' })
vim.keymap.set('n', '<C-y>', '<C-r>', { desc = 'Redo' })
vim.keymap.set('i', '<C-y>', '<Esc><C-r>a', { desc = 'Redo (insert mode)' })

-- Cut, Copy, Paste
vim.keymap.set('v', '<C-x>', '"+x', { desc = 'Cut' })
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy' })
vim.keymap.set('n', '<C-v>', '"+p', { desc = 'Paste' })
vim.keymap.set('i', '<C-v>', '<C-r>+', { desc = 'Paste (insert mode)' })
vim.keymap.set('c', '<C-v>', '<C-r>+', { desc = 'Paste (command mode)' })

-- Select all
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all' })

-- Quick Open (File finder)
vim.keymap.set('n', '<C-p>', function()
  require('telescope.builtin').find_files()
end, { desc = 'Quick Open Files' })

-- Command Palette
vim.keymap.set('n', '<C-S-p>', function()
  require('telescope.builtin').commands()
end, { desc = 'Command Palette' })

-- Find in current file
vim.keymap.set('n', '<C-f>', '/', { desc = 'Find in current file' })
vim.keymap.set('v', '<C-f>', '/', { desc = 'Find in current file' })

-- Replace in current file
vim.keymap.set('n', '<C-h>', ':s/', { desc = 'Replace in current file' })
vim.keymap.set('v', '<C-h>', ':s/', { desc = 'Replace in selection' })

-- Find in files (project-wide search)
vim.keymap.set('n', '<C-S-f>', function()
  require('telescope.builtin').live_grep()
end, { desc = 'Find in Files' })

-- Replace in files (project-wide replace)
vim.keymap.set('n', '<C-S-h>', function()
  require('spectre').open()
end, { desc = 'Replace in Files' })

-- Go to line
vim.keymap.set('n', '<C-g>', ':lua vim.ui.input({prompt="Go to line: "}, function(input) if input then vim.cmd("normal! " .. input .. "G") end end)<CR>', { desc = 'Go to Line' })

-- Line operations
vim.keymap.set('n', '<C-S-k>', 'dd', { desc = 'Delete Line' })
vim.keymap.set('i', '<C-S-k>', '<Esc>dda', { desc = 'Delete Line (insert mode)' })

vim.keymap.set('n', '<C-CR>', 'o<Esc>', { desc = 'Insert Line Below' })
vim.keymap.set('i', '<C-CR>', '<Esc>o', { desc = 'Insert Line Below (insert mode)' })

vim.keymap.set('n', '<C-S-CR>', 'O<Esc>', { desc = 'Insert Line Above' })
vim.keymap.set('i', '<C-S-CR>', '<Esc>O', { desc = 'Insert Line Above (insert mode)' })

-- Line comments (requires Comment.nvim plugin)
vim.keymap.set('n', '<C-/>', function()
  require('Comment.api').toggle.linewise.current()
end, { desc = 'Toggle Line Comment' })

vim.keymap.set('v', '<C-/>', function()
  local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
  vim.api.nvim_feedkeys(esc, 'nx', false)
  require('Comment.api').toggle.linewise(vim.fn.visualmode())
end, { desc = 'Toggle Line Comment' })

-- Block comments
vim.keymap.set('v', '<C-S-/>', function()
  local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
  vim.api.nvim_feedkeys(esc, 'nx', false)
  require('Comment.api').toggle.blockwise(vim.fn.visualmode())
end, { desc = 'Toggle Block Comment' })

-- Indentation
vim.keymap.set('n', '<C-]>', '>>', { desc = 'Indent Line' })
vim.keymap.set('n', '<C-[>', '<<', { desc = 'Outdent Line' })
vim.keymap.set('v', '<C-]>', '>gv', { desc = 'Indent Selection' })
vim.keymap.set('v', '<C-[>', '<gv', { desc = 'Outdent Selection' })

-- Editor navigation
vim.keymap.set('n', '<C-Tab>', ':bnext<CR>', { desc = 'Next Editor' })
vim.keymap.set('n', '<C-S-Tab>', ':bprevious<CR>', { desc = 'Previous Editor' })

-- Close editor/tab
vim.keymap.set('n', '<C-w>', ':bd<CR>', { desc = 'Close Editor' })
vim.keymap.set('n', '<C-S-w>', ':bd!<CR>', { desc = 'Close Editor (force)' })

-- New window
vim.keymap.set('n', '<C-S-n>', ':tabnew<CR>', { desc = 'New Window' })

-- Reopen closed editor (if available)
vim.keymap.set('n', '<C-S-t>', ':e #<CR>', { desc = 'Reopen Last Closed Editor' })

-- Terminal
vim.keymap.set('n', '<C-S-`>', function()
  vim.cmd('split')
  vim.cmd('terminal')
  vim.cmd('resize 15')
end, { desc = 'New Terminal' })

-- Symbol navigation (LSP)
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = 'Rename Symbol' })
vim.keymap.set('n', '<F12>', vim.lsp.buf.definition, { desc = 'Go to Definition' })
vim.keymap.set('n', '<S-F12>', function()
  require('telescope.builtin').lsp_references()
end, { desc = 'Find All References' })

-- Workspace symbols
vim.keymap.set('n', '<C-t>', function()
  require('telescope.builtin').lsp_workspace_symbols()
end, { desc = 'Go to Symbol in Workspace' })

-- Show problems/diagnostics panel
vim.keymap.set('n', '<C-S-m>', function()
  require('telescope.builtin').diagnostics()
end, { desc = 'Show Problems' })

-- Format document
vim.keymap.set('n', '<A-S-f>', function()
  require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Format Document' })

-- Multi-cursor selection (with vim-visual-multi)
vim.keymap.set('n', '<C-d>', '<Plug>(VM-Find-Under)', { desc = 'Add Selection to Next Find Match' })
vim.keymap.set('v', '<C-d>', '<Plug>(VM-Find-Subword-Under)', { desc = 'Add Selection to Next Find Match' })

-- Peek definition
vim.keymap.set('n', '<A-F12>', function()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
    if result and #result > 0 then
      vim.lsp.util.preview_location(result[1], { border = 'rounded' })
    end
  end)
end, { desc = 'Peek Definition' })

-- Show hover information
vim.keymap.set('n', '<C-k><C-i>', vim.lsp.buf.hover, { desc = 'Show Hover Information' })

-- Parameter hints
vim.keymap.set('n', '<C-S-Space>', vim.lsp.buf.signature_help, { desc = 'Parameter Hints' })
vim.keymap.set('i', '<C-S-Space>', vim.lsp.buf.signature_help, { desc = 'Parameter Hints' })

-- Quick fix
vim.keymap.set('n', '<C-.>', vim.lsp.buf.code_action, { desc = 'Quick Fix' })

-- Fold/Unfold
vim.keymap.set('n', '<C-S-[>', 'zc', { desc = 'Fold' })
vim.keymap.set('n', '<C-S-]>', 'zo', { desc = 'Unfold' })
vim.keymap.set('n', '<C-k><C-0>', 'zM', { desc = 'Fold All' })
vim.keymap.set('n', '<C-k><C-j>', 'zR', { desc = 'Unfold All' })

-- Navigate between problems
vim.keymap.set('n', '<F8>', vim.diagnostic.goto_next, { desc = 'Next Problem' })
vim.keymap.set('n', '<S-F8>', vim.diagnostic.goto_prev, { desc = 'Previous Problem' })

-- Additional file operations
vim.keymap.set('n', '<C-k><C-o>', function()
  require('telescope.builtin').oldfiles()
end, { desc = 'Open Recent' })

-- Zen mode (requires zen-mode plugin)
vim.keymap.set('n', '<C-k>z', function()
  local ok, zen_mode = pcall(require, 'zen-mode')
  if ok then
    zen_mode.toggle()
  else
    print("Zen mode not available")
  end
end, { desc = 'Toggle Zen Mode' })

-- Organize imports (VSCode-like)
vim.keymap.set('n', '<C-A-o>', function()
  -- Try TypeScript organize imports first
  local params = {
    command = '_typescript.organizeImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
  -- Then try generic code actions for other languages
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { 'source.organizeImports' },
      diagnostics = {},
    },
  })
end, { desc = 'Organize Imports' })

-- Split editor
vim.keymap.set('n', '<C-\\>', ':vs<CR>', { desc = 'Split Editor Right' })
vim.keymap.set('n', '<C-k><C-\\>', ':split<CR>', { desc = 'Split Editor Down' })