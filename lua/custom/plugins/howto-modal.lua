--- How-To Modal: A quick reference guide for Neovim commands
--- Opens a floating window with helpful commands and shortcuts
--- Provides VSCode-like command reference for easy transition
--- @module howto-modal

return {
  -- Create a custom how-to modal plugin
  {
    'folke/which-key.nvim',
    optional = true,
  },
  
  -- We'll use a simple approach with a custom command
  {
    dir = vim.fn.stdpath('config'),
    name = 'howto-modal',
    config = function()
      -- Create the how-to content
      local howto_content = {
        '╔═══════════════════════════════════════════════════════════════════════════╗',
        '║                     NEOVIM QUICK REFERENCE GUIDE                          ║',
        '╚═══════════════════════════════════════════════════════════════════════════╝',
        '',
        '┌─ FILE OPERATIONS ────────────────────────────────────────────────────────┐',
        '│ <Ctrl+S>          Save current file                                      │',
        '│ <Ctrl+Shift+S>    Save all files                                         │',
        '│ <Ctrl+P>          Quick open files (fuzzy finder)                        │',
        '│ <Ctrl+Shift+P>    Command palette                                        │',
        '│ <Ctrl+B>          Toggle file explorer sidebar                           │',
        '│ <Ctrl+Shift+E>    Toggle file explorer sidebar (alternative)             │',
        '│ <Ctrl+N>          New file                                               │',
        '│ <Ctrl+W>          Close current buffer                                   │',
        '└──────────────────────────────────────────────────────────────────────────┘',
        '',
        '┌─ EDITING ────────────────────────────────────────────────────────────────┐',
        '│ <Ctrl+Z>          Undo                                                    │',
        '│ <Ctrl+Y>          Redo                                                    │',
        '│ <Ctrl+C>          Copy (in visual mode)                                  │',
        '│ <Ctrl+X>          Cut (in visual mode)                                   │',
        '│ <Ctrl+V>          Paste                                                   │',
        '│ <Ctrl+A>          Select all                                             │',
        '│ <Ctrl+/>          Toggle line comment                                    │',
        '│ <Ctrl+D>          Multi-cursor: select next occurrence                   │',
        '│ <Alt+Up/Down>     Move line up/down                                      │',
        '│ <Ctrl+Shift+K>    Delete line                                            │',
        '└──────────────────────────────────────────────────────────────────────────┘',
        '',
        '┌─ SEARCH & NAVIGATION ────────────────────────────────────────────────────┐',
        '│ <Ctrl+F>          Find in current file                                   │',
        '│ <Ctrl+R>          Replace in current file (changed from Ctrl+H)          │',
        '│ <Ctrl+Shift+F>    Find in all files (project-wide)                       │',
        '│ <Ctrl+Shift+H>    Replace in all files (project-wide)                    │',
        '│ <Ctrl+G>          Go to line                                             │',
        '│ <Ctrl+T>          Go to symbol in workspace                              │',
        '│ <F12>             Go to definition                                       │',
        '│ <Shift+F12>       Find all references                                    │',
        '│ <Alt+F12>         Peek definition                                        │',
        '│ <F2>              Rename symbol                                          │',
        '└──────────────────────────────────────────────────────────────────────────┘',
        '',
        '┌─ WINDOW MANAGEMENT ──────────────────────────────────────────────────────┐',
        '│ <Ctrl+\\>         Split editor vertically                                │',
        '│ <Ctrl+H/J/K/L>    Navigate between windows                               │',
        '│ <Ctrl+Tab>        Next buffer                                            │',
        '│ <Ctrl+Shift+Tab>  Previous buffer                                        │',
        '│ <leader>w-        Split window horizontally                              │',
        '│ <leader>w|        Split window vertically                                │',
        '│ <leader>wd        Close window                                           │',
        '└──────────────────────────────────────────────────────────────────────────┘',
        '',
        '┌─ TERMINAL ───────────────────────────────────────────────────────────────┐',
        '│ <Ctrl+`>          Toggle floating terminal                               │',
        '│ <Ctrl+Shift+`>    Toggle horizontal terminal                             │',
        '│ <Esc>             Exit terminal mode (in terminal)                       │',
        '└──────────────────────────────────────────────────────────────────────────┘',
        '',
        '┌─ CODE INTELLIGENCE ──────────────────────────────────────────────────────┐',
        '│ <Ctrl+.>          Quick fix / Code actions                               │',
        '│ <Ctrl+Space>      Show completion menu                                   │',
        '│ <leader>f         Format document                                        │',
        '│ <F8>              Next diagnostic/problem                                │',
        '│ <Shift+F8>        Previous diagnostic/problem                            │',
        '│ <Ctrl+Shift+M>    Show problems panel                                    │',
        '│ grd               Go to definition (LSP)                                 │',
        '│ grr               Find references (LSP)                                  │',
        '│ grn               Rename symbol (LSP)                                    │',
        '└──────────────────────────────────────────────────────────────────────────┘',
        '',
        '┌─ GIT INTEGRATION ────────────────────────────────────────────────────────┐',
        '│ <Ctrl+Shift+G>    Open Git UI (Neogit)                                   │',
        '│ <leader>gg        Open Git UI (Neogit)                                   │',
        '│ <leader>gb        Toggle git blame                                       │',
        '│ <leader>hs        Stage hunk                                             │',
        '│ <leader>hr        Reset hunk                                             │',
        '│ <leader>hp        Preview hunk                                           │',
        '│ ]c / [c           Jump to next/previous git change                       │',
        '└──────────────────────────────────────────────────────────────────────────┘',
        '',
        '┌─ SPECIAL FEATURES ───────────────────────────────────────────────────────┐',
        '│ <leader>?         Show this help (How-To modal)                          │',
        '│ <F1>              Show this help (How-To modal)                          │',
        '│ <Ctrl+K>Z         Toggle Zen mode (distraction-free)                     │',
        '│ <leader>mm        Toggle code minimap                                    │',
        '│ <leader>xx        Toggle Trouble (diagnostics panel)                     │',
        '│ <leader>S         Search and replace (Spectre)                           │',
        '│ <leader>pp        Project switcher                                       │',
        '└──────────────────────────────────────────────────────────────────────────┘',
        '',
        '┌─ THEME SWITCHING ────────────────────────────────────────────────────────┐',
        '│ <leader>tt        Open theme picker (Telescope)                          │',
        '│ <leader>tv        Switch to VSCode theme                                 │',
        '│ <leader>to        Switch to Tokyo Night theme                            │',
        '│ <leader>tc        Switch to Catppuccin theme                             │',
        '│ <leader>td        Switch to Dracula theme                                │',
        '│ <leader>tn        Switch to Nord theme                                   │',
        '│ <leader>tg        Switch to Gruvbox theme                                │',
        '└──────────────────────────────────────────────────────────────────────────┘',
        '',
        '┌─ GITHUB COPILOT ─────────────────────────────────────────────────────────┐',
        '│ <Alt+L>           Accept Copilot suggestion                              │',
        '│ <Alt+]>           Next Copilot suggestion                                │',
        '│ <Alt+[>           Previous Copilot suggestion                            │',
        '│ <Ctrl+]>          Dismiss Copilot suggestion                             │',
        '│ <leader>cp        Open Copilot panel                                     │',
        '│ <leader>cs        Show Copilot status                                    │',
        '└──────────────────────────────────────────────────────────────────────────┘',
        '',
        '┌─ BASIC VIM MOTIONS ──────────────────────────────────────────────────────┐',
        '│ h/j/k/l           Move left/down/up/right                                │',
        '│ w / b             Jump forward/backward by word                          │',
        '│ 0 / $             Jump to start/end of line                              │',
        '│ gg / G            Jump to start/end of file                              │',
        '│ i / a             Insert before/after cursor                             │',
        '│ o / O             Insert new line below/above                            │',
        '│ v                 Visual mode (select text)                              │',
        '│ V                 Visual line mode                                       │',
        '│ <Ctrl+V>          Visual block mode                                      │',
        '│ y                 Yank (copy) selection                                  │',
        '│ d                 Delete selection                                       │',
        '│ p                 Paste after cursor                                     │',
        '│ u                 Undo                                                    │',
        '│ <Ctrl+R>          Redo                                                    │',
        '└──────────────────────────────────────────────────────────────────────────┘',
        '',
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
        '  Press <q> or <Esc> to close this window                                  ',
        '  Press <Space> to see more keybindings with Which-Key                     ',
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
      }

      -- Function to show the how-to modal
      local function show_howto_modal()
        -- Create a buffer
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
        vim.api.nvim_buf_set_option(buf, 'filetype', 'howto')

        -- Set the content
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, howto_content)
        vim.api.nvim_buf_set_option(buf, 'modifiable', false)

        -- Get editor dimensions
        local width = vim.api.nvim_get_option("columns")
        local height = vim.api.nvim_get_option("lines")

        -- Calculate window size (80% of editor)
        local win_height = math.ceil(height * 0.85)
        local win_width = math.ceil(width * 0.85)

        -- Calculate starting position
        local row = math.ceil((height - win_height) / 2)
        local col = math.ceil((width - win_width) / 2)

        -- Set window options
        local opts = {
          style = "minimal",
          relative = "editor",
          width = win_width,
          height = win_height,
          row = row,
          col = col,
          border = "rounded",
          title = " How-To Guide ",
          title_pos = "center",
        }

        -- Create the window
        local win = vim.api.nvim_open_win(buf, true, opts)
        vim.api.nvim_win_set_option(win, 'winblend', 0)
        vim.api.nvim_win_set_option(win, 'cursorline', true)

        -- Set highlight for the window
        vim.api.nvim_win_set_option(win, 'winhighlight', 'Normal:Normal,FloatBorder:FloatBorder')

        -- Keymaps to close the window
        local keymaps_opts = { noremap = true, silent = true, buffer = buf }
        vim.keymap.set('n', 'q', '<cmd>close<CR>', keymaps_opts)
        vim.keymap.set('n', '<Esc>', '<cmd>close<CR>', keymaps_opts)
        vim.keymap.set('n', '<Space>', function()
          vim.cmd('close')
          require('which-key').show()
        end, keymaps_opts)
      end

      -- Create the command
      vim.api.nvim_create_user_command('HowTo', show_howto_modal, { desc = 'Show Neovim How-To Guide' })

      -- Set up keybindings
      vim.keymap.set('n', '<leader>?', show_howto_modal, { desc = 'Show How-To Guide', noremap = true, silent = true })
      vim.keymap.set('n', '<F1>', show_howto_modal, { desc = 'Show How-To Guide', noremap = true, silent = true })
      
      -- Also add to which-key if available
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
