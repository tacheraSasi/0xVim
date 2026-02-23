--- How-To Modal: A quick reference guide for Neovim commands
--- Opens a floating window with helpful commands and shortcuts
--- Dynamically shows Cmd (Mac) or Ctrl (Linux) based on vim.g.is_mac
--- @module custom.plugins.howto-modal

return {
  {
    'folke/which-key.nvim',
    optional = true,
  },

  {
    dir = vim.fn.stdpath('config'),
    name = 'howto-modal',
    config = function()
      -- OS-aware modifier key label
      local K = vim.g.is_mac and 'Cmd' or 'Ctrl'
      local os_note = vim.g.is_mac and '(Mac - Cmd key)' or '(Linux - Ctrl key)'

      -- Helper: pad a line to fixed width with trailing box character
      local function L(text)
        local display_len = vim.fn.strdisplaywidth(text)
        local pad = math.max(0, 75 - display_len)
        return text .. string.rep(' ', pad) .. '\xe2\x94\x82'
      end

      local D = '\xe2\x94\x80' -- box drawing: horizontal line
      local V = '\xe2\x94\x82' -- box drawing: vertical line

      -- Create the how-to content
      local howto_content = {
        '\xe2\x95\x94' .. string.rep('\xe2\x95\x90', 75) .. '\xe2\x95\x97',
        '\xe2\x95\x91' .. '            NEOVIM QUICK REFERENCE GUIDE  ' .. os_note .. string.rep(' ', math.max(1, 32 - #os_note)) .. '\xe2\x95\x91',
        '\xe2\x95\x9a' .. string.rep('\xe2\x95\x90', 75) .. '\xe2\x95\x9d',
        '',
        '\xe2\x94\x8c\xe2\x94\x80 FILE OPERATIONS ' .. string.rep(D, 57) .. '\xe2\x94\x90',
        L(V .. ' <' .. K .. '+S>          Save current file'),
        L(V .. ' <' .. K .. '+Shift+S>    Save all files'),
        L(V .. ' <' .. K .. '+P>          Quick open files (fuzzy finder)'),
        L(V .. ' <' .. K .. '+Shift+P>    Command palette'),
        L(V .. ' <' .. K .. '+B>          Toggle file explorer sidebar'),
        L(V .. ' <' .. K .. '+Shift+E>    Focus file explorer sidebar'),
        L(V .. ' <' .. K .. '+N>          New file'),
        L(V .. ' <' .. K .. '+Shift+W>    Close current buffer'),
        '\xe2\x94\x94' .. string.rep(D, 75) .. '\xe2\x94\x98',
        '',
        '\xe2\x94\x8c\xe2\x94\x80 EDITING ' .. string.rep(D, 66) .. '\xe2\x94\x90',
        L(V .. ' <' .. K .. '+Z>          Undo'),
        L(V .. ' <' .. K .. '+Y>          Redo'),
        L(V .. ' <' .. K .. '+C>          Copy (in visual mode)'),
        L(V .. ' <' .. K .. '+X>          Cut (in visual mode)'),
        L(V .. ' <' .. K .. '+V>          Paste'),
        L(V .. ' <' .. K .. '+A>          Select all'),
        L(V .. ' <' .. K .. '+/>          Toggle line comment'),
        L(V .. ' <' .. K .. '+D>          Multi-cursor: select next occurrence'),
        L(V .. ' <Alt+Up/Down>     Move line up/down'),
        L(V .. ' <' .. K .. '+Shift+K>    Delete line'),
        L(V .. ' <Shift+Alt+Down>  Duplicate line down'),
        '\xe2\x94\x94' .. string.rep(D, 75) .. '\xe2\x94\x98',
        '',
        '\xe2\x94\x8c\xe2\x94\x80 SEARCH & NAVIGATION ' .. string.rep(D, 54) .. '\xe2\x94\x90',
        L(V .. ' <' .. K .. '+F>          Find in current file'),
        L(V .. ' <' .. K .. '+R>          Replace in current file'),
        L(V .. ' <' .. K .. '+Shift+F>    Find in all files (project-wide)'),
        L(V .. ' <' .. K .. '+Shift+H>    Replace in all files (Spectre)'),
        L(V .. ' <' .. K .. '+G>          Go to line'),
        L(V .. ' <' .. K .. '+T>          Go to symbol in workspace'),
        L(V .. ' <F12>             Go to definition'),
        L(V .. ' <Shift+F12>       Find all references'),
        L(V .. ' <Alt+F12>         Peek definition'),
        L(V .. ' <F2>              Rename symbol'),
        L(V .. ' <' .. K .. '+Shift+R>    Recent files'),
        '\xe2\x94\x94' .. string.rep(D, 75) .. '\xe2\x94\x98',
        '',
        '\xe2\x94\x8c\xe2\x94\x80 SIDEBAR & EXPLORER ' .. string.rep(D, 55) .. '\xe2\x94\x90',
        L(V .. ' <' .. K .. '+B>          Toggle sidebar (smart: focus/close)'),
        L(V .. ' <' .. K .. '+0>          Focus sidebar explorer'),
        L(V .. ' <' .. K .. '+1>          Focus editor (back from sidebar)'),
        L(V .. ' <Esc>             Close sidebar (when focused)'),
        L(V .. ' h / l             Collapse / Expand folder (in tree)'),
        L(V .. ' <Enter>           Open file (in tree)'),
        '\xe2\x94\x94' .. string.rep(D, 75) .. '\xe2\x94\x98',
        '',
        '\xe2\x94\x8c\xe2\x94\x80 WINDOW MANAGEMENT ' .. string.rep(D, 56) .. '\xe2\x94\x90',
        L(V .. ' <' .. K .. '+\\\\>         Split editor vertically'),
        L(V .. ' <Ctrl+H/J/K/L>    Navigate between windows'),
        L(V .. ' <Ctrl+Tab>        Next buffer'),
        L(V .. ' <Ctrl+Shift+Tab>  Previous buffer'),
        L(V .. ' <leader>w-        Split window horizontally'),
        L(V .. ' <leader>w|        Split window vertically'),
        L(V .. ' <leader>wd        Close window'),
        '\xe2\x94\x94' .. string.rep(D, 75) .. '\xe2\x94\x98',
        '',
        '\xe2\x94\x8c\xe2\x94\x80 TERMINAL ' .. string.rep(D, 65) .. '\xe2\x94\x90',
        L(V .. ' <Ctrl+`>          Toggle floating terminal'),
        L(V .. ' <' .. K .. '+Shift+`>    Open horizontal terminal'),
        L(V .. ' <Esc>             Exit terminal mode'),
        '\xe2\x94\x94' .. string.rep(D, 75) .. '\xe2\x94\x98',
        '',
        '\xe2\x94\x8c\xe2\x94\x80 CODE INTELLIGENCE ' .. string.rep(D, 56) .. '\xe2\x94\x90',
        L(V .. ' <' .. K .. '+.>          Quick fix / Code actions'),
        L(V .. ' <' .. K .. '+Shift+Space> Completion hints'),
        L(V .. ' <Alt+Shift+F>     Format document'),
        L(V .. ' <F8>              Next diagnostic/problem'),
        L(V .. ' <Shift+F8>        Previous diagnostic/problem'),
        L(V .. ' <' .. K .. '+Shift+M>    Show problems panel (Trouble)'),
        L(V .. ' grd               Go to definition (LSP)'),
        L(V .. ' grr               Find references (LSP)'),
        L(V .. ' grn               Rename symbol (LSP)'),
        L(V .. ' <' .. K .. '+Shift+[>    Fold code block'),
        L(V .. ' <' .. K .. '+Shift+]>    Unfold code block'),
        '\xe2\x94\x94' .. string.rep(D, 75) .. '\xe2\x94\x98',
        '',
        '\xe2\x94\x8c\xe2\x94\x80 GIT INTEGRATION ' .. string.rep(D, 58) .. '\xe2\x94\x90',
        L(V .. ' <' .. K .. '+Shift+G>    Open Git UI (Neogit)'),
        L(V .. ' <leader>gg        Open Git UI (Neogit)'),
        L(V .. ' <leader>gb        Toggle git blame'),
        L(V .. ' <leader>hs        Stage hunk'),
        L(V .. ' <leader>hr        Reset hunk'),
        L(V .. ' <leader>hp        Preview hunk'),
        L(V .. ' ]c / [c           Next/previous git change'),
        '\xe2\x94\x94' .. string.rep(D, 75) .. '\xe2\x94\x98',
        '',
        '\xe2\x94\x8c\xe2\x94\x80 SPECIAL FEATURES ' .. string.rep(D, 57) .. '\xe2\x94\x90',
        L(V .. ' <leader>?         Show this help (How-To modal)'),
        L(V .. ' <F1>              Show this help (How-To modal)'),
        L(V .. ' <' .. K .. '+K>Z         Toggle Zen mode'),
        L(V .. ' <leader>mm        Toggle code minimap'),
        L(V .. ' <leader>xx        Toggle Trouble (diagnostics)'),
        L(V .. ' <leader>S         Search and replace (Spectre)'),
        L(V .. ' <leader>pp        Project switcher'),
        L(V .. ' <' .. K .. '+Shift+X>    Show Extensions (Lazy)'),
        L(V .. ' <' .. K .. '+,>          Open settings (init.lua)'),
        L(V .. ' <Alt+Z>           Toggle word wrap'),
        '\xe2\x94\x94' .. string.rep(D, 75) .. '\xe2\x94\x98',
        '',
        '\xe2\x94\x8c\xe2\x94\x80 THEME SWITCHING ' .. string.rep(D, 58) .. '\xe2\x94\x90',
        L(V .. ' <leader>tt        Open theme picker (Telescope)'),
        L(V .. ' <leader>tv        Switch to VSCode theme'),
        L(V .. ' <leader>to        Switch to Tokyo Night theme'),
        L(V .. ' <leader>tc        Switch to Catppuccin theme'),
        L(V .. ' <leader>tD        Switch to Dracula theme'),
        L(V .. ' <leader>tn        Switch to Nord theme'),
        L(V .. ' <leader>tg        Switch to Gruvbox theme'),
        '\xe2\x94\x94' .. string.rep(D, 75) .. '\xe2\x94\x98',
        '',
        '\xe2\x94\x8c\xe2\x94\x80 GITHUB COPILOT ' .. string.rep(D, 59) .. '\xe2\x94\x90',
        L(V .. ' <Alt+L>           Accept Copilot suggestion'),
        L(V .. ' <Alt+]>           Next Copilot suggestion'),
        L(V .. ' <Alt+[>           Previous Copilot suggestion'),
        L(V .. ' <Ctrl+]>          Dismiss Copilot suggestion'),
        L(V .. ' <leader>cp        Open Copilot panel'),
        L(V .. ' <leader>cs        Show Copilot status'),
        '\xe2\x94\x94' .. string.rep(D, 75) .. '\xe2\x94\x98',
        '',
        '\xe2\x94\x8c\xe2\x94\x80 BASIC VIM MOTIONS ' .. string.rep(D, 56) .. '\xe2\x94\x90',
        L(V .. ' h/j/k/l           Move left/down/up/right'),
        L(V .. ' w / b             Jump forward/backward by word'),
        L(V .. ' 0 / $             Jump to start/end of line'),
        L(V .. ' gg / G            Jump to start/end of file'),
        L(V .. ' i / a             Insert before/after cursor'),
        L(V .. ' o / O             Insert new line below/above'),
        L(V .. ' v                 Visual mode (select text)'),
        L(V .. ' V                 Visual line mode'),
        L(V .. ' <Ctrl+V>          Visual block mode'),
        L(V .. ' y                 Yank (copy) selection'),
        L(V .. ' d                 Delete selection'),
        L(V .. ' p                 Paste after cursor'),
        L(V .. ' u                 Undo'),
        L(V .. ' <Ctrl+R>          Redo'),
        '\xe2\x94\x94' .. string.rep(D, 75) .. '\xe2\x94\x98',
        '',
        string.rep(D, 77),
        '  Press <q> or <Esc> to close this window',
        '  Press <Space> to see more keybindings with Which-Key',
        '  OS: ' .. os_note .. ' | Change: vim.g.is_mac in lua/custom/init.lua',
        string.rep(D, 77),
      }

      -- Function to show the how-to modal
      local function show_howto_modal()
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
        vim.api.nvim_buf_set_option(buf, 'filetype', 'howto')

        vim.api.nvim_buf_set_lines(buf, 0, -1, false, howto_content)
        vim.api.nvim_buf_set_option(buf, 'modifiable', false)

        local width = vim.api.nvim_get_option("columns")
        local height = vim.api.nvim_get_option("lines")

        local win_height = math.ceil(height * 0.85)
        local win_width = math.ceil(width * 0.85)

        local row = math.ceil((height - win_height) / 2)
        local col = math.ceil((width - win_width) / 2)

        local opts = {
          style = "minimal",
          relative = "editor",
          width = win_width,
          height = win_height,
          row = row,
          col = col,
          border = "rounded",
          title = " How-To Guide " .. os_note .. " ",
          title_pos = "center",
        }

        local win = vim.api.nvim_open_win(buf, true, opts)
        vim.api.nvim_win_set_option(win, 'winblend', 0)
        vim.api.nvim_win_set_option(win, 'cursorline', true)
        vim.api.nvim_win_set_option(win, 'winhighlight', 'Normal:Normal,FloatBorder:FloatBorder')

        local keymaps_opts = { noremap = true, silent = true, buffer = buf }
        vim.keymap.set('n', 'q', '<cmd>close<CR>', keymaps_opts)
        vim.keymap.set('n', '<Esc>', '<cmd>close<CR>', keymaps_opts)
        vim.keymap.set('n', '<Space>', function()
          vim.cmd('close')
          require('which-key').show()
        end, keymaps_opts)
      end

      vim.api.nvim_create_user_command('HowTo', show_howto_modal, { desc = 'Show Neovim How-To Guide' })

      vim.keymap.set('n', '<leader>?', show_howto_modal, { desc = 'Show How-To Guide', noremap = true, silent = true })
      vim.keymap.set('n', '<F1>', show_howto_modal, { desc = 'Show How-To Guide', noremap = true, silent = true })

      local ok, which_key = pcall(require, 'which-key')
      if ok then
        which_key.add({
          { '<leader>?', desc = 'Show How-To Guide' },
          { '<F1>', desc = 'Show How-To Guide' },
        })
      end
    end,
  },
}
