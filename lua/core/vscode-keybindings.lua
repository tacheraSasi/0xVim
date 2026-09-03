-- VS Code-compatible keybindings with macOS Cmd mirrors.
-- On macOS, any <C-...> binding below is also mirrored to <D-...> (Cmd)
-- so the muscle memory matches VSCode/Zed exactly.

local function vscode_map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
  if vim.g.is_mac then
    local cmd_lhs = lhs:gsub('<C%-', '<D-')
    if cmd_lhs ~= lhs then
      vim.keymap.set(mode, cmd_lhs, rhs, opts)
    end
  end
end

-- Add luarocks bin to PATH only if it actually exists.
local luarocks_bin = vim.fn.expand '~/.luarocks/bin'
if vim.fn.isdirectory(luarocks_bin) == 1 and not string.find(vim.env.PATH or '', luarocks_bin, 1, true) then
  vim.env.PATH = vim.env.PATH .. ':' .. luarocks_bin
end

-- File / Save
vscode_map('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })
vscode_map('i', '<C-s>', '<Esc><cmd>w<CR>a', { desc = 'Save file (insert)' })
-- Cmd+S additionally exits insert mode (Vim muscle memory); Ctrl+S stays in insert.
if vim.g.is_mac then
  vim.keymap.set('i', '<D-s>', '<Esc><cmd>w<CR>', { desc = 'Save file and exit insert mode' })
end
vscode_map('n', '<C-S-s>', '<cmd>wa<CR>', { desc = 'Save all files' })

-- Undo / Redo
vscode_map('n', '<C-z>', 'u', { desc = 'Undo' })
vscode_map('i', '<C-z>', '<Esc>ua', { desc = 'Undo (insert)' })
vscode_map('n', '<C-y>', '<C-r>', { desc = 'Redo' })
vscode_map('i', '<C-y>', '<Esc><C-r>a', { desc = 'Redo (insert)' })

-- Clipboard
vscode_map('v', '<C-x>', '"+x', { desc = 'Cut' })
vscode_map('v', '<C-c>', '"+y', { desc = 'Copy' })
vscode_map('n', '<C-v>', '"+p', { desc = 'Paste' })
vscode_map('i', '<C-v>', '<C-r>+', { desc = 'Paste (insert)' })
vscode_map('c', '<C-v>', '<C-r>+', { desc = 'Paste (command)' })
vscode_map('n', '<C-a>', 'ggVG', { desc = 'Select all' })

-- Cursor movement (Zed / VSCode-style with Option + arrows)
-- <M-Left>  = back a word       (Zed: Opt-←)
-- <M-Right> = forward a word    (Zed: Opt-→)
-- <M-Up>    = start of paragraph / block  (Zed: Opt-↑)
-- <M-Down>  = end of paragraph / block    (Zed: Opt-↓)
-- <D-Left>  = start of line     (Zed: Cmd-←)
-- <D-Right> = end of line       (Zed: Cmd-→)
-- <D-Up>    = top of file       (Zed: Cmd-↑)
-- <D-Down>  = bottom of file    (Zed: Cmd-↓)
-- Normal mode: use native motions. Insert mode: use <C-o> to run one
-- normal command then return to insert, so cursor stays fluid while typing.
vim.keymap.set({ 'n', 'v' }, '<M-Left>', 'b', { desc = 'Word back' })
vim.keymap.set({ 'n', 'v' }, '<M-Right>', 'w', { desc = 'Word forward' })
vim.keymap.set('i', '<M-Left>', '<C-o>b', { desc = 'Word back (insert)' })
vim.keymap.set('i', '<M-Right>', '<C-o>w', { desc = 'Word forward (insert)' })
vim.keymap.set({ 'n', 'v', 'i' }, '<M-Up>', '{', { desc = 'Paragraph back' })
vim.keymap.set({ 'n', 'v', 'i' }, '<M-Down>', '}', { desc = 'Paragraph forward' })

-- Terminal.app sends <M-b>/<M-f> for Opt+Left/Opt+Right (not arrow keys).
-- Map those too so word-motion works regardless of which terminal encoding.
vim.keymap.set({ 'n', 'v' }, '<M-b>', 'b', { desc = 'Word back' })
vim.keymap.set({ 'n', 'v' }, '<M-f>', 'w', { desc = 'Word forward' })
vim.keymap.set('i', '<M-b>', '<C-o>b', { desc = 'Word back (insert)' })
vim.keymap.set('i', '<M-f>', '<C-o>w', { desc = 'Word forward (insert)' })

-- Many macOS terminals (iTerm2, Ghostty, Alacritty, kitty, WezTerm) send
-- raw CSI escape sequences for Option+arrow rather than <M-Left>. Map those
-- explicitly so Opt+arrows work no matter which terminal you use.
-- We map every common variant of the sequence to cover terminal quirks.
local esc = string.char(27)
local seqs = {
  right = { '[1;3C', '[1;5C', '[5C', '[3C', 'OC' },
  left  = { '[1;3D', '[1;5D', '[5D', '[3D', 'OD' },
  up    = { '[1;3A', '[1;5A', '[5A', '[3A', 'OA' },
  down  = { '[1;3B', '[1;5B', '[5B', '[3B', 'OB' },
}
local motion = { right = 'w', left = 'b', up = '{', down = '}' }
local motion_i = { right = '<C-o>w', left = '<C-o>b', up = '<C-o>{', down = '<C-o>}' }
for dir, list in pairs(seqs) do
  for _, body in ipairs(list) do
    local key = esc .. body
    vim.keymap.set({ 'n', 'v' }, key, motion[dir], { desc = 'Word ' .. dir })
    vim.keymap.set('i', key, motion_i[dir], { desc = 'Word ' .. dir .. ' (insert)' })
  end
end

if vim.g.is_mac then
  vim.keymap.set({ 'n', 'v' }, '<D-Left>', '0', { desc = 'Line start' })
  vim.keymap.set({ 'n', 'v' }, '<D-Right>', '$', { desc = 'Line end' })
  vim.keymap.set('i', '<D-Left>', '<C-o>0', { desc = 'Line start (insert)' })
  vim.keymap.set('i', '<D-Right>', '<C-o>$', { desc = 'Line end (insert)' })
  vim.keymap.set({ 'n', 'v' }, '<D-Up>', 'gg', { desc = 'Top of file' })
  vim.keymap.set({ 'n', 'v' }, '<D-Down>', 'G', { desc = 'Bottom of file' })
  vim.keymap.set('i', '<D-Up>', '<C-o>gg', { desc = 'Top of file (insert)' })
  vim.keymap.set('i', '<D-Down>', '<C-o>G', { desc = 'Bottom of file (insert)' })
end

-- Word-wise deletion (Zed: Opt-Backspace deletes a word, Cmd-Backspace to line start)
vim.keymap.set('i', '<M-Backspace>', '<C-w>', { desc = 'Delete word back (insert)' })
vim.keymap.set('i', '<M-Delete>', '<C-o>de', { desc = 'Delete word forward (insert)' })
if vim.g.is_mac then
  vim.keymap.set('i', '<D-Backspace>', '<C-u>', { desc = 'Delete to line start (insert)' })
  vim.keymap.set('i', '<D-Delete>', '<C-o>d$', { desc = 'Delete to line end (insert)' })
end

-- Word-wise selection (Zed: Shift+Opt+arrows extends by word)
vim.keymap.set('v', '<M-Left>', 'b', { desc = 'Select word back' })
vim.keymap.set('v', '<M-Right>', 'w', { desc = 'Select word forward' })
if vim.g.is_mac then
  vim.keymap.set('v', '<D-Left>', '0', { desc = 'Select to line start' })
  vim.keymap.set('v', '<D-Right>', '$', { desc = 'Select to line end' })
end

-- Quick Open / Command Palette
vscode_map('n', '<C-p>', function() require('telescope.builtin').find_files {} end, { desc = 'Quick Open' })
vscode_map('n', '<C-S-p>', function() require('telescope.builtin').commands() end, { desc = 'Command Palette' })

-- Find / Replace
vscode_map({ 'n', 'v' }, '<C-f>', '/', { desc = 'Find in file' })
vscode_map('n', '<C-r>', ':s/', { desc = 'Replace in file' })
vscode_map('v', '<C-r>', ':s/', { desc = 'Replace in selection' })
vscode_map('n', '<C-S-f>', function() require('telescope.builtin').live_grep() end, { desc = 'Find in Files' })
vscode_map('n', '<C-S-h>', function()
  local ok, spectre = pcall(require, 'spectre')
  if ok then spectre.open() else vim.notify('Spectre not available', vim.log.levels.WARN) end
end, { desc = 'Replace in Files' })
vscode_map('n', '<C-g>', function()
  vim.ui.input({ prompt = 'Go to line: ' }, function(input)
    local line = tonumber(input)
    if line then vim.cmd('normal! ' .. line .. 'G') end
  end)
end, { desc = 'Go to Line' })

-- Editor: line ops
vscode_map('n', '<C-S-k>', 'dd', { desc = 'Delete Line' })
vscode_map('i', '<C-S-k>', '<Esc>dda', { desc = 'Delete Line (insert)' })
vscode_map('n', '<C-CR>', 'o<Esc>', { desc = 'Insert Line Below' })
vscode_map('i', '<C-CR>', '<Esc>o', { desc = 'Insert Line Below (insert)' })
vscode_map('n', '<C-S-CR>', 'O<Esc>', { desc = 'Insert Line Above' })
vscode_map('i', '<C-S-CR>', '<Esc>O', { desc = 'Insert Line Above (insert)' })

-- Comment toggle (VSCode uses Ctrl+/; many terminals send Ctrl+_ for it)
local function toggle_comment()
  local ok, api = pcall(require, 'Comment.api')
  if ok then
    api.toggle.linewise.current()
  else
    vim.cmd 'normal gcc'
  end
end
local function toggle_comment_visual()
  local ok, api = pcall(require, 'Comment.api')
  if ok then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'nx', false)
    api.toggle.linewise(vim.fn.visualmode())
  else
    vim.cmd("'<,'>normal gcc")
  end
end
vscode_map('n', '<C-/>', toggle_comment, { desc = 'Toggle Line Comment' })
vscode_map('n', '<C-_>', toggle_comment, { desc = 'Toggle Line Comment (alt)' })
vscode_map('x', '<C-/>', toggle_comment_visual, { desc = 'Toggle Line Comment' })
vscode_map('x', '<C-_>', toggle_comment_visual, { desc = 'Toggle Line Comment (alt)' })

-- VSCode chord comment toggles: Ctrl+K Ctrl+C / Ctrl+K Ctrl+U
vim.keymap.set('n', '<C-k><C-c>', toggle_comment, { desc = 'Comment Lines (chord)' })
vim.keymap.set('x', '<C-k><C-c>', toggle_comment_visual, { desc = 'Comment Lines (chord)' })
vim.keymap.set('n', '<C-k><C-u>', toggle_comment, { desc = 'Uncomment Lines (chord)' })
vim.keymap.set('x', '<C-k><C-u>', toggle_comment_visual, { desc = 'Uncomment Lines (chord)' })

-- Indent / Outdent
vscode_map('n', '<C-]>', '>>', { desc = 'Indent Line' })
vscode_map('n', '<C-[>', '<<', { desc = 'Outdent Line' })
vscode_map('v', '<C-]>', '>gv', { desc = 'Indent Selection' })
vscode_map('v', '<C-[>', '<gv', { desc = 'Outdent Selection' })

-- Editor tabs (buffers)
vscode_map('n', '<C-Tab>', '<cmd>bnext<CR>', { desc = 'Next Editor' })
vscode_map('n', '<C-S-Tab>', '<cmd>bprevious<CR>', { desc = 'Previous Editor' })
vscode_map('n', '<C-S-w>', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local buftype = vim.bo[bufnr].buftype
  if buftype ~= '' then
    vim.cmd('bd! ' .. bufnr)
    return
  end
  local real_buffers = 0
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buftype == '' and vim.bo[b].filetype ~= '' then
      real_buffers = real_buffers + 1
    end
  end
  if real_buffers <= 1 then
    vim.cmd('bd ' .. bufnr)
    local ok = pcall(vim.cmd, 'Dashboard')
    if not ok then vim.cmd('enew') end
  else
    local prev_buf = vim.fn.bufnr('#')
    if prev_buf > 0 and vim.api.nvim_buf_is_loaded(prev_buf) and prev_buf ~= bufnr then
      vim.cmd('buffer ' .. prev_buf)
      vim.cmd('bd ' .. bufnr)
    else
      vim.cmd('bd ' .. bufnr)
    end
  end
end, { desc = 'Close Editor (smart)' })
vscode_map('n', '<C-S-n>', '<cmd>tabnew<CR>', { desc = 'New Window' })
vscode_map('n', '<C-S-t>', '<cmd>e #<CR>', { desc = 'Reopen Closed Editor' })

-- Terminal
vscode_map('n', '<C-S-`>', function()
  local ok = pcall(require, 'toggleterm')
  if ok then
    vim.cmd 'ToggleTerm direction=float'
  else
    vim.cmd 'split | terminal | resize 15'
  end
end, { desc = 'New Terminal' })

-- LSP / Refactoring
vscode_map('n', '<F2>', vim.lsp.buf.rename, { desc = 'Rename Symbol' })
vscode_map('n', '<F12>', vim.lsp.buf.definition, { desc = 'Go to Definition' })
vscode_map('n', '<C-LeftMouse>', vim.lsp.buf.definition, { desc = 'Go to Definition (Cmd/Ctrl+Click)' })
vscode_map('n', '<S-F12>', function() require('goto-preview').goto_preview_references() end, { desc = 'Find References (popup)' })
vscode_map('n', '<C-t>', function() require('telescope.builtin').lsp_workspace_symbols() end, { desc = 'Go to Symbol' })
vscode_map('n', '<C-S-o>', function() require('telescope.builtin').lsp_document_symbols() end, { desc = 'File Symbols' })
vscode_map('n', '<C-S-r>', function() require('telescope.builtin').oldfiles() end, { desc = 'Recent Files' })
vscode_map('n', '<C-S-m>', function()
  local ok = pcall(vim.cmd, 'Trouble diagnostics toggle')
  if not ok then require('telescope.builtin').diagnostics() end
end, { desc = 'Show Problems' })
vscode_map('n', '<A-S-f>', function() require('conform').format { async = true, lsp_format = 'fallback' } end, { desc = 'Format Document' })
vscode_map('n', '<A-F12>', function()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result)
    if result and #result > 0 then vim.lsp.util.preview_location(result[1], { border = 'rounded' }) end
  end)
end, { desc = 'Peek Definition' })
vscode_map('n', '<C-.>', vim.lsp.buf.code_action, { desc = 'Quick Fix' })

-- Diagnostics nav
vscode_map('n', '<F8>', function() vim.diagnostic.goto_next {} end, { desc = 'Next Problem' })
vscode_map('n', '<S-F8>', function() vim.diagnostic.goto_prev {} end, { desc = 'Previous Problem' })

-- Split editor
vscode_map('n', '<C-\\>', '<cmd>vs<CR>', { desc = 'Split Editor Right' })

-- Sidebar / Explorer focus
-- Primary toggle is <C-b> (registered in neo-tree.lua). Mirror to Cmd+B on macOS.
if vim.g.is_mac then
  vim.keymap.set('n', '<D-b>', function()
    local manager = require 'neo-tree.sources.manager'
    local state = manager.get_state 'filesystem'
    local visible = state and state.winid and vim.api.nvim_win_is_valid(state.winid)
    if visible then
      require('neo-tree.command').execute { action = 'close', source = 'filesystem' }
      local target = _G.__nvim_last_editor_win and _G.__nvim_last_editor_win()
      if target and vim.api.nvim_win_is_valid(target) then
        vim.api.nvim_set_current_win(target)
      end
    else
      require('neo-tree.command').execute { action = 'focus', source = 'filesystem', toggle = false }
    end
  end, { desc = 'Toggle file explorer', silent = true })
end

vscode_map('n', '<C-0>', function()
  local ok = pcall(vim.cmd, 'Neotree focus filesystem right')
  if not ok then pcall(vim.cmd, 'Neotree show filesystem right') end
end, { desc = 'Focus Sidebar' })

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
  vim.cmd 'wincmd p'
end, { desc = 'Focus Editor' })

-- Source Control
vscode_map('n', '<C-S-g>', function()
  local ok = pcall(vim.cmd, 'Neogit')
  if not ok then vim.notify('Neogit not available', vim.log.levels.WARN) end
end, { desc = 'Source Control' })

-- Move line / selection
vscode_map('n', '<A-Up>', ':m .-2<CR>==', { desc = 'Move Line Up' })
vscode_map('n', '<A-Down>', ':m .+1<CR>==', { desc = 'Move Line Down' })
vscode_map('v', '<A-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move Selection Up' })
vscode_map('v', '<A-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move Selection Down' })

-- Toggle word wrap
vscode_map('n', '<A-z>', function()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify('Word wrap: ' .. (vim.wo.wrap and 'enabled' or 'disabled'))
end, { desc = 'Toggle Word Wrap' })

-- New File / Settings
vscode_map('n', '<C-n>', '<cmd>enew<CR>', { desc = 'New File' })
vscode_map('n', '<C-,>', function() vim.cmd('edit ' .. vim.fn.stdpath 'config' .. '/init.lua') end, { desc = 'Open Settings' })

-- Font zoom (VSCode Ctrl+= / Ctrl+-)
local function zoom_font(delta)
  local cur = vim.o.guifont == '' and 14 or tonumber(vim.o.guifont:match ':h(%d+)') or 14
  local next = math.max(6, cur + delta)
  if vim.o.guifont ~= '' then
    vim.o.guifont = vim.o.guifont:gsub(':h%d+', ':h' .. next)
  else
    if vim.g.neovide then vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1) * (next / cur) end
  end
  vim.notify('Font size: ' .. next)
end
vscode_map('n', '<C-=>', function() zoom_font(1) end, { desc = 'Zoom In' })
vscode_map('n', '<C-->', function() zoom_font(-1) end, { desc = 'Zoom Out' })
