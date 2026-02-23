--- VSCode-like keybindings for Neovim
--- This file implements comprehensive VSCode keyboard shortcuts to provide
--- a familiar experience for VSCode users transitioning to Neovim.
--- @module custom.vscode-keybindings

-- ═══════════════════════════════════════════════════════════════════════════
-- OS-aware keybinding helper
-- On Mac: adds Cmd (<D->) duplicate for every Ctrl mapping (both work)
-- On Linux: only Ctrl mappings are set
-- Toggle vim.g.is_mac in custom/init.lua to switch OS
-- ═══════════════════════════════════════════════════════════════════════════
local function vscode_map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
  if vim.g.is_mac then
    local cmd_lhs = lhs:gsub('<C%-', '<D-')
    if cmd_lhs ~= lhs then
      vim.keymap.set(mode, cmd_lhs, rhs, opts)
    end
  end
end

--- File operations: Save, save all
--- VSCode equivalents: Ctrl+S, Ctrl+Shift+S
vscode_map('n', '<C-s>', ':w<CR>', { desc = 'Save file' })
vscode_map('i', '<C-s>', '<Esc>:w<CR>a', { desc = 'Save file (insert mode)' })
vscode_map('n', '<C-S-s>', ':wa<CR>', { desc = 'Save all files' })

--- Undo/Redo operations
--- VSCode equivalents: Ctrl+Z (undo), Ctrl+Y (redo)
vscode_map('n', '<C-z>', 'u', { desc = 'Undo' })
vscode_map('i', '<C-z>', '<Esc>ua', { desc = 'Undo (insert mode)' })
vscode_map('n', '<C-y>', '<C-r>', { desc = 'Redo' })
vscode_map('i', '<C-y>', '<Esc><C-r>a', { desc = 'Redo (insert mode)' })

--- Clipboard operations: Cut, Copy, Paste
--- VSCode equivalents: Ctrl+X, Ctrl+C, Ctrl+V
vscode_map('v', '<C-x>', '"+x', { desc = 'Cut' })
vscode_map('v', '<C-c>', '"+y', { desc = 'Copy' })
vscode_map('n', '<C-v>', '"+p', { desc = 'Paste' })
vscode_map('i', '<C-v>', '<C-r>+', { desc = 'Paste (insert mode)' })
vscode_map('c', '<C-v>', '<C-r>+', { desc = 'Paste (command mode)' })

--- Select all text in current buffer
--- VSCode equivalent: Ctrl+A
vscode_map('n', '<C-a>', 'ggVG', { desc = 'Select all' })

--- Quick Open: Fuzzy file finder with smart filtering
--- Excludes: node_modules, dist, build, .git, etc.
--- VSCode equivalent: Ctrl+P
vscode_map('n', '<C-p>', function()
  require('telescope.builtin').find_files({
    -- Use the global Telescope configuration for find_files
    -- The filters are already configured in the Telescope setup
  })
end, { desc = 'Quick Open Files (filtered)' })

--- Command Palette: Access all available commands
--- Note: Project switcher uses <leader>pp to avoid conflict
--- VSCode equivalent: Ctrl+Shift+P
vscode_map('n', '<C-S-p>', function()
  require('telescope.builtin').commands()
end, { desc = 'Command Palette' })

--- Find in current file
--- VSCode equivalent: Ctrl+F
vscode_map('n', '<C-f>', '/', { desc = 'Find in current file' })
vscode_map('v', '<C-f>', '/', { desc = 'Find in current file' })

--- Replace in current file
--- Using Ctrl+R to avoid conflict with window navigation <C-h>
--- VSCode uses Ctrl+H, but we changed it to Ctrl+R for compatibility
vscode_map('n', '<C-r>', ':s/', { desc = 'Replace in current file' })
vscode_map('v', '<C-r>', ':s/', { desc = 'Replace in selection' })

--- Find in files: Project-wide search using live grep
--- VSCode equivalent: Ctrl+Shift+F
vscode_map('n', '<C-S-f>', function()
  require('telescope.builtin').live_grep()
end, { desc = 'Find in Files' })

--- Replace in files: Project-wide search and replace with Spectre
--- VSCode equivalent: Ctrl+Shift+H
vscode_map('n', '<C-S-h>', function()
  local ok, spectre = pcall(require, 'spectre')
  if ok then
    spectre.open()
  else
    print('Spectre plugin not available')
  end
end, { desc = 'Replace in Files' })

--- Go to line: Jump to a specific line number
--- VSCode equivalent: Ctrl+G
vscode_map('n', '<C-g>',
  ':lua vim.ui.input({prompt="Go to line: "}, function(input) if input then vim.cmd("normal! " .. input .. "G") end end)<CR>',
  { desc = 'Go to Line' })

--- Line operations: Delete, insert above/below
--- VSCode equivalents: Ctrl+Shift+K (delete), Ctrl+Enter (insert below), Ctrl+Shift+Enter (insert above)
vscode_map('n', '<C-S-k>', 'dd', { desc = 'Delete Line' })
vscode_map('i', '<C-S-k>', '<Esc>dda', { desc = 'Delete Line (insert mode)' })

vscode_map('n', '<C-CR>', 'o<Esc>', { desc = 'Insert Line Below' })
vscode_map('i', '<C-CR>', '<Esc>o', { desc = 'Insert Line Below (insert mode)' })

vscode_map('n', '<C-S-CR>', 'O<Esc>', { desc = 'Insert Line Above' })
vscode_map('i', '<C-S-CR>', '<Esc>O', { desc = 'Insert Line Above (insert mode)' })

--- Line comments: Toggle line comments
--- Requires Comment.nvim plugin
--- VSCode equivalent: Ctrl+/
vscode_map('n', '<C-/>', function()
  local ok, comment_api = pcall(require, 'Comment.api')
  if ok then
    comment_api.toggle.linewise.current()
  else
    -- Fallback to simple commenting
    vim.cmd('normal gcc')
  end
end, { desc = 'Toggle Line Comment' })

vscode_map('v', '<C-/>', function()
  local ok, comment_api = pcall(require, 'Comment.api')
  if ok then
    local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'nx', false)
    comment_api.toggle.linewise(vim.fn.visualmode())
  else
    -- Fallback to simple commenting
    vim.cmd("'<,'>normal gcc")
  end
end, { desc = 'Toggle Line Comment' })

--- Block comments: Toggle block comments
--- VSCode equivalent: Ctrl+Shift+/
vscode_map('v', '<C-S-/>', function()
  local ok, comment_api = pcall(require, 'Comment.api')
  if ok then
    local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'nx', false)
    comment_api.toggle.blockwise(vim.fn.visualmode())
  else
    -- Fallback to simple commenting
    vim.cmd("'<,'>normal gbc")
  end
end, { desc = 'Toggle Block Comment' })

--- Indentation: Indent and outdent lines or selections
--- VSCode equivalents: Ctrl+] (indent), Ctrl+[ (outdent)
vscode_map('n', '<C-]>', '>>', { desc = 'Indent Line' })
vscode_map('n', '<C-[>', '<<', { desc = 'Outdent Line' })
vscode_map('v', '<C-]>', '>gv', { desc = 'Indent Selection' })
vscode_map('v', '<C-[>', '<gv', { desc = 'Outdent Selection' })

--- Editor navigation: Window movement with Ctrl+h/j/k/l
--- VSCode uses Ctrl+1/2/3, but we use vim-style navigation
vscode_map('n', '<C-Tab>', ':bnext<CR>', { desc = 'Next Editor' })
vscode_map('n', '<C-S-Tab>', ':bprevious<CR>', { desc = 'Previous Editor' })

-- Close editor/tab
-- NOTE: <C-w> conflicts with Vim's window command prefix (<C-w>h/j/k/l for navigation)
-- Use :bd or <leader>bd instead, or use <C-S-w> as alternative
vscode_map('n', '<C-S-w>', ':bd<CR>', { desc = 'Close Editor' })
vscode_map('n', '<C-S-w><C-S-w>', ':bd!<CR>', { desc = 'Close Editor (force)' })

-- New window
vscode_map('n', '<C-S-n>', ':tabnew<CR>', { desc = 'New Window' })

-- Reopen closed editor (if available)
vscode_map('n', '<C-S-t>', ':e #<CR>', { desc = 'Reopen Last Closed Editor' })

-- Terminal (Ctrl+Shift+`)
vscode_map('n', '<C-S-`>', function()
  local ok, _ = pcall(require, 'toggleterm')
  if ok then
    vim.cmd('ToggleTerm direction=horizontal')
  else
    vim.cmd('split')
    vim.cmd('terminal')
    vim.cmd('resize 15')
  end
end, { desc = 'New Terminal' })

-- Symbol navigation (LSP)
vscode_map('n', '<F2>', vim.lsp.buf.rename, { desc = 'Rename Symbol' })
vscode_map('n', '<F12>', vim.lsp.buf.definition, { desc = 'Go to Definition' })
vscode_map('n', '<S-F12>', function()
  require('telescope.builtin').lsp_references()
end, { desc = 'Find All References' })

-- Workspace symbols
vscode_map('n', '<C-t>', function()
  require('telescope.builtin').lsp_workspace_symbols()
end, { desc = 'Go to Symbol in Workspace' })

-- Show problems/diagnostics panel (Ctrl+Shift+M)
vscode_map('n', '<C-S-m>', function()
  local ok, trouble = pcall(require, 'trouble')
  if ok then
    vim.cmd('Trouble diagnostics toggle')
  else
    require('telescope.builtin').diagnostics()
  end
end, { desc = 'Show Problems' })

-- Format document
vscode_map('n', '<A-S-f>', function()
  require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Format Document' })

-- Multi-cursor selection (with vim-visual-multi if available)
vscode_map('n', '<C-d>', function()
  -- Check if vim-visual-multi is available
  if vim.fn.exists('*vm#commands#find_under') == 1 then
    vim.cmd('call vm#commands#find_under(0, 1)')
  else
    -- Fallback to default behavior
    vim.cmd('normal! viw')
  end
end, { desc = 'Add Selection to Next Find Match' })

vscode_map('v', '<C-d>', function()
  -- Check if vim-visual-multi is available
  if vim.fn.exists('*vm#commands#find_subword_under') == 1 then
    vim.cmd('call vm#commands#find_subword_under(0, 1)')
  else
    -- Fallback to default behavior
    vim.cmd('normal! gv')
  end
end, { desc = 'Add Selection to Next Find Match' })

-- Peek definition
vscode_map('n', '<A-F12>', function()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
    if result and #result > 0 then
      vim.lsp.util.preview_location(result[1], { border = 'rounded' })
    end
  end)
end, { desc = 'Peek Definition' })

-- Show hover information
vscode_map('n', '<C-k><C-i>', vim.lsp.buf.hover, { desc = 'Show Hover Information' })

-- Parameter hints
vscode_map('n', '<C-S-Space>', vim.lsp.buf.signature_help, { desc = 'Parameter Hints' })
vscode_map('i', '<C-S-Space>', vim.lsp.buf.signature_help, { desc = 'Parameter Hints' })

-- Quick fix
vscode_map('n', '<C-.>', vim.lsp.buf.code_action, { desc = 'Quick Fix' })

-- Fold/Unfold
vscode_map('n', '<C-S-[>', 'zc', { desc = 'Fold' })
vscode_map('n', '<C-S-]>', 'zo', { desc = 'Unfold' })
vscode_map('n', '<C-k><C-0>', 'zM', { desc = 'Fold All' })
vscode_map('n', '<C-k><C-j>', 'zR', { desc = 'Unfold All' })

-- Navigate between problems
vscode_map('n', '<F8>', vim.diagnostic.goto_next, { desc = 'Next Problem' })
vscode_map('n', '<S-F8>', vim.diagnostic.goto_prev, { desc = 'Previous Problem' })

-- Additional file operations
vscode_map('n', '<C-k><C-o>', function()
  require('telescope.builtin').oldfiles()
end, { desc = 'Open Recent' })

-- Zen mode (requires zen-mode plugin)
vscode_map('n', '<C-k>z', function()
  local ok, zen_mode = pcall(require, 'zen-mode')
  if ok then
    zen_mode.toggle()
  else
    print("Zen mode not available")
  end
end, { desc = 'Toggle Zen Mode' })

-- Organize imports (VSCode-like)
vscode_map('n', '<C-A-o>', function()
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
vscode_map('n', '<C-\\>', ':vs<CR>', { desc = 'Split Editor Right' })
vscode_map('n', '<C-k><C-\\>', ':split<CR>', { desc = 'Split Editor Down' })

-- Explorer/File tree toggle (Ctrl+B or Ctrl+Shift+E)
-- Main Ctrl+B handler is in enhanced-vscode.lua Neo-tree keys config
vscode_map('n', '<C-b>', function()
  local ok, manager = pcall(require, 'neo-tree.sources.manager')
  if ok then
    local renderer = require('neo-tree.ui.renderer')
    local state = manager.get_state('filesystem')
    local window_exists = renderer.window_exists(state)
    if window_exists then
      local neo_tree_win = state.winid
      if neo_tree_win and vim.api.nvim_win_is_valid(neo_tree_win) and vim.api.nvim_get_current_win() == neo_tree_win then
        vim.cmd('Neotree close')
      else
        vim.cmd('Neotree focus')
      end
    else
      vim.cmd('Neotree show')
    end
  else
    pcall(vim.cmd, 'Neotree toggle')
  end
end, { desc = 'Toggle Sidebar Visibility', silent = true })

vscode_map('n', '<C-S-e>', function()
  vim.cmd('Neotree focus')
end, { desc = 'Focus Explorer', silent = true })

-- Focus sidebar explorer (VSCode Ctrl+0)
vscode_map('n', '<C-0>', function()
  local ok = pcall(vim.cmd, 'Neotree focus')
  if not ok then pcall(vim.cmd, 'Neotree show') end
end, { desc = 'Focus Sidebar (Explorer)' })

-- Focus editor (VSCode Ctrl+1) - jump back from sidebar to editor
vscode_map('n', '<C-1>', function()
  local wins = vim.api.nvim_list_wins()
  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.bo[buf].filetype
    local bt = vim.bo[buf].buftype
    if ft ~= 'neo-tree' and ft ~= 'toggleterm' and bt ~= 'nofile' and bt ~= 'terminal' then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  vim.cmd('wincmd p')
end, { desc = 'Focus Editor' })

-- Source Control (Ctrl+Shift+G)
vscode_map('n', '<C-S-g>', function()
  local ok, _ = pcall(require, 'neogit')
  if ok then
    vim.cmd('Neogit')
  else
    print('Neogit plugin not available')
  end
end, { desc = 'Source Control' })

-- Run and Debug (Ctrl+Shift+D)
vscode_map('n', '<C-S-d>', function()
  local ok, dap = pcall(require, 'dap')
  if ok then
    dap.continue()
  else
    print('DAP (debugger) not available')
  end
end, { desc = 'Start Debugging' })

-- Show Extensions (plugins) (Ctrl+Shift+X)
vscode_map('n', '<C-S-x>', ':Lazy<CR>', { desc = 'Show Extensions (Plugins)' })

-- Go to Symbol in Workspace (Ctrl+Shift+O)
vscode_map('n', '<C-S-o>', function()
  require('telescope.builtin').lsp_workspace_symbols()
end, { desc = 'Go to Symbol in Workspace' })

-- Output panel (Ctrl+Shift+U)
vscode_map('n', '<C-S-u>', function()
  local ok, _ = pcall(require, 'trouble')
  if ok then
    vim.cmd('Trouble qflist toggle')
  else
    vim.cmd('copen')
  end
end, { desc = 'Output Panel' })

-- Breadcrumb navigation (Ctrl+Shift+;)
vscode_map('n', '<C-S-;>', function()
  require('telescope.builtin').lsp_document_symbols()
end, { desc = 'Go to Symbol in Editor' })

-- Recent files (like VSCode's Ctrl+Shift+R to avoid conflict with Replace)
vscode_map('n', '<C-S-r>', function()
  require('telescope.builtin').oldfiles()
end, { desc = 'Recent Files' })

-- Duplicate line (like VSCode's Shift+Alt+Down)
vscode_map('n', '<S-A-Down>', 'yyp', { desc = 'Duplicate Line Down' })
vscode_map('n', '<S-A-Up>', 'yyP', { desc = 'Duplicate Line Up' })

-- Move line up/down (like VSCode's Alt+Up/Down)
vscode_map('n', '<A-Up>', ':m .-2<CR>==', { desc = 'Move Line Up' })
vscode_map('n', '<A-Down>', ':m .+1<CR>==', { desc = 'Move Line Down' })
vscode_map('v', '<A-Up>', ':m \'<-2<CR>gv=gv', { desc = 'Move Selection Up' })
vscode_map('v', '<A-Down>', ':m \'>+1<CR>gv=gv', { desc = 'Move Selection Down' })

-- Add cursor above/below (multi-cursor like VSCode's Ctrl+Alt+Up/Down)
vscode_map('n', '<C-A-Up>', function()
  if vim.fn.exists('*vm#commands#add_cursor_up') == 1 then
    vim.cmd('call vm#commands#add_cursor_up(0, 1)')
  else
    print('Multi-cursor plugin not available')
  end
end, { desc = 'Add Cursor Above' })

vscode_map('n', '<C-A-Down>', function()
  if vim.fn.exists('*vm#commands#add_cursor_down') == 1 then
    vim.cmd('call vm#commands#add_cursor_down(0, 1)')
  else
    print('Multi-cursor plugin not available')
  end
end, { desc = 'Add Cursor Below' })

-- Select all occurrences (like VSCode's Ctrl+Shift+L)
vscode_map('n', '<C-S-l>', function()
  if vim.fn.exists('*vm#commands#find_all') == 1 then
    vim.cmd('call vm#commands#find_all(0, 1)')
  else
    print('Multi-cursor plugin not available')
  end
end, { desc = 'Select All Occurrences' })

-- NOTE: F2, F12, S-F12, C-., C-F12, S-A-f, Ctrl+Shift+F12 are already defined above

-- Toggle word wrap (like VSCode's Alt+Z)
vscode_map('n', '<A-z>', function()
  vim.wo.wrap = not vim.wo.wrap
  print('Word wrap: ' .. (vim.wo.wrap and 'enabled' or 'disabled'))
end, { desc = 'Toggle Word Wrap' })

-- NOTE: Focus editor (Ctrl+1) and Focus sidebar (Ctrl+0) are defined above

-- Close all editors (like VSCode's Ctrl+K Ctrl+W)
vscode_map('n', '<C-k><C-w>', ':bufdo bd<CR>', { desc = 'Close All Editors' })

-- Save all (like VSCode's Ctrl+K S)
vscode_map('n', '<C-k>s', ':wall<CR>', { desc = 'Save All' })

-- New file (like VSCode's Ctrl+N)
vscode_map('n', '<C-n>', ':enew<CR>', { desc = 'New File' })

-- Open folder (like VSCode's Ctrl+K Ctrl+O)
vscode_map('n', '<C-k><C-o>', function()
  local ok, telescope = pcall(require, 'telescope')
  if ok and telescope.extensions and telescope.extensions.projects then
    telescope.extensions.projects.projects {}
  else
    require('telescope.builtin').oldfiles()
  end
end, { desc = 'Open Folder' })

-- Settings (like VSCode's Ctrl+,)
vscode_map('n', '<C-,>', function()
  vim.cmd('edit ' .. vim.fn.stdpath('config') .. '/init.lua')
end, { desc = 'Open Settings' })

-- Keyboard shortcuts (like VSCode's Ctrl+K Ctrl+S)
vscode_map('n', '<C-k><C-s>', function()
  require('telescope.builtin').keymaps()
end, { desc = 'Keyboard Shortcuts' })

-- Transform to uppercase/lowercase (like VSCode's Ctrl+Shift+U)
vscode_map('v', '<C-S-u>', 'gU', { desc = 'Transform to Uppercase' })

-- NOTE: Zen mode (Ctrl+K Z) is already defined above
