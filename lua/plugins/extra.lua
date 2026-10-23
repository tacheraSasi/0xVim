return {
  -- navic (breadcrumbs)
  {
    'SmiteshP/nvim-navic',
    dependencies = 'neovim/nvim-lspconfig',
    opts = { highlight = false, separator = ' > ', depth_limit = 0, safe_output = true },
  },
  -- nvim-lightbulb: show a gutter lightbulb when code actions are available (VSCode-style)
  {
    'kosayoda/nvim-lightbulb',
    event = 'LspAttach',
    opts = {
      action_kinds = nil,
      sign = { enabled = true, text = '', hl = 'LightBulbSign' },
      float = { enabled = false },
      status_text = { enabled = false },
      number = { enabled = false },
      ignore = { ft = { 'neo-tree', 'toggleterm', 'TelescopePrompt', 'Trouble' } },
      autocmd = { enabled = true, pattern = { 'CursorHold', 'CursorHoldI' }, mode = 'n' },
    },
  },
  -- rainbow-delimiters: bracket-pair colorization (VSCode "Bracket Pair Colorization")
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'BufReadPost',
    config = function()
      require('rainbow-delimiters.setup').setup {
        strategy = {
          [''] = 'rainbow-delimiters.strategy.local',
          vim = 'rainbow-delimiters.strategy.local',
          query = { [''] = 'rainbow-delimiters', latex = 'rainbow-blocks' },
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },
  -- git-blame
  {
    'f-person/git-blame.nvim',
    opts = {},
    config = function()
      vim.g.gitblame_enabled = 1
      vim.g.gitblame_message_template = '<author> • <date> • <summary>'
      vim.g.gitblame_date_format = '%r'
      vim.g.gitblame_highlight_group = 'Comment'
      vim.keymap.set('n', '<leader>gb', '<Cmd>GitBlameToggle<CR>', { desc = 'Toggle git blame' })
    end,
  },
  -- neogit (enhanced git UI)
  {
    'NeogitOrg/neogit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('neogit').setup {
        disable_signs = false, disable_hint = false, disable_context_highlighting = false,
        disable_commit_confirmation = false, auto_refresh = true, use_magit_keybindings = false,
        -- Let NeoGit's review action (d w / d s) hand off to Diffview.
        integrations = { diffview = true },
        highlight = {
          -- Keep syntax/word emphasis inside the diff hunks.
          treesitter_diff_highlight = true,
          word_diff_highlight = true,
        },
      }

      -- NeoGit paints whole added/deleted lines with a solid green/red
      -- background, which flattens everything into blocks and hides any syntax
      -- colours. Keep the tint, drop the opaque background instead.
      local function neogit_diff_highlights()
        for _, group in ipairs {
          'NeogitDiffAdd', 'NeogitDiffAddHighlight',
          'NeogitDiffDelete', 'NeogitDiffDeleteHighlight',
        } do
          vim.api.nvim_set_hl(0, group, { bg = 'NONE', ctermbg = 'NONE' })
        end
      end
      neogit_diff_highlights()
      vim.api.nvim_create_autocmd('ColorScheme', { callback = neogit_diff_highlights })
      vim.api.nvim_create_autocmd('FileType', { pattern = 'Neogit*', callback = neogit_diff_highlights })
      vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<CR>', { desc = 'Open Neogit' })
      vim.keymap.set('n', '<leader>gc', '<cmd>Neogit commit<CR>', { desc = 'Git commit' })
      vim.keymap.set('n', '<leader>gp', '<cmd>Neogit push<CR>', { desc = 'Git push' })
      vim.keymap.set('n', '<leader>gl', '<cmd>Neogit pull<CR>', { desc = 'Git pull' })
    end,
  },
  -- diffview.nvim — multi-file / side-by-side diffs WITH real syntax highlighting
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = {
      'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory',
      'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewRefresh',
    },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = 'Diffview (uncommitted)' },
      { '<leader>gD', '<cmd>DiffviewClose<CR>', desc = 'Close Diffview' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', desc = 'File history' },
    },
    opts = {
      -- The whole point: highlight the diff with the real file syntax
      -- instead of NeoGit's solid green/red blocks.
      enhanced_diff_hl = true,
      view = {
        default = { layout = 'diff2_horizontal' },
      },
    },
  },
  -- zdiff.nvim — Zed-style multi-buffer diff view (treesitter highlighted)
  -- :Zdiff        → uncommitted changes (vs HEAD)
  -- :Zdiff <ref>  → compare against a branch / tag / commit
  -- setup() is deprecated upstream; mappings are configured per buffer via
  -- a FileType autocmd (see https://github.com/martindur/zdiff.nvim).
  {
    'martindur/zdiff.nvim',
    cmd = { 'Zdiff', 'ZdiffToggle', 'ZdiffOpen', 'ZdiffRefresh' },
    keys = {
      { '<leader>zd', '<cmd>Zdiff<CR>', desc = 'Zdiff (uncommitted)' },
      {
        '<leader>zD',
        function()
          -- Repos here use master and main, so ask instead of hardcoding one.
          vim.ui.input({ prompt = 'Zdiff vs ref (branch/tag/commit): ' }, function(ref)
            if ref and ref ~= '' then require('zdiff').open(ref) end
          end)
        end,
        desc = 'Zdiff (vs ref)',
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'zdiff',
        callback = function(event)
          local o = { buffer = event.buf, silent = true }
          vim.keymap.set('n', '<CR>', '<cmd>ZdiffOpen<cr>', o)
          vim.keymap.set('n', '<Tab>', '<cmd>ZdiffToggle<cr>', o)
          vim.keymap.set('n', 'R', '<cmd>ZdiffRefresh<cr>', o)
          -- q closes every zdiff window, then returns focus to the file you
          -- came from — otherwise, if the explorer was open, it would be the
          -- last window standing and take over the screen.
          -- If zdiff is the ONLY window, closing it would fail with E444
          -- (and ":q" from there would quit Neovim entirely) — so drop a
          -- real file buffer into the window first, then wipe zdiff.
          vim.keymap.set('n', 'q', function()
            local wins = vim.api.nvim_tabpage_list_wins(0)
            local zwins, others = {}, {}
            for _, w in ipairs(wins) do
              if vim.api.nvim_win_is_valid(w) then
                local buf = vim.api.nvim_win_get_buf(w)
                if vim.bo[buf].filetype == 'zdiff' then
                  zwins[#zwins + 1] = w
                elseif
                  vim.fn.win_gettype(w) == ''
                  and vim.bo[buf].buftype == ''
                  and vim.bo[buf].buflisted
                then
                  others[#others + 1] = w
                end
              end
            end

            if #others == 0 then
              -- zdiff owns every window: swap in a real buffer so the
              -- window can't be the "last window" exit path.
              local target
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if
                  vim.bo[buf].buftype == ''
                  and vim.bo[buf].buflisted
                  and vim.api.nvim_buf_is_loaded(buf)
                  and vim.bo[buf].filetype ~= 'zdiff'
                  and vim.api.nvim_buf_get_name(buf) ~= ''
                then
                  target = buf
                  break
                end
              end
              vim.api.nvim_win_set_buf(0, target or vim.api.nvim_create_buf(true, false))
            end

            for _, w in ipairs(zwins) do
              -- in the "others==0" case the current window has already been
              -- swapped to a real buffer, so check the filetype here too
              if
                vim.api.nvim_win_is_valid(w)
                and vim.bo[vim.api.nvim_win_get_buf(w)].filetype == 'zdiff'
              then
                pcall(vim.api.nvim_win_close, w, false)
              end
            end

            -- Wipe every zdiff session buffer (triggers their cleanup autocmds)
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_valid(buf) and vim.b[buf].zdiff then
                pcall(vim.cmd, 'bwipeout! ' .. buf)
              end
            end

            if #others > 0 then
              require('core.explorer').focus_editor()
            end
          end, o)
          -- m: flip between uncommitted changes and comparison against main.
          vim.keymap.set('n', 'm', function()
            if vim.b[event.buf].zdiff.base == '' then
              vim.cmd('Zdiff main')
            else
              vim.cmd('Zdiff')
            end
          end, o)
        end,
      })
    end,
  },
  -- nvim-dap (debugger)
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      require('mason-nvim-dap').setup {
        automatic_setup = true, handlers = {},
        ensure_installed = { 'delve', 'codelldb', 'js-debug-adapter', 'php-debug-adapter' },
      }

      -- TS/JS (pwa-node): js-debug-adapter has no mason-nvim-dap mapping yet
      dap.adapters['pwa-node'] = {
        type = 'server',
        host = '127.0.0.1',
        port = '${port}',
        executable = { command = 'js-debug-adapter', args = { '${port}' } },
      }
      -- PHP / Laravel (Xdebug) — listens on port 9003 by default
      dap.adapters.php = {
        type = 'executable',
        command = 'php-debug-adapter',
      }

      dapui.setup {
        icons = { expanded = '', collapsed = '', current_frame = '' },
        layouts = {
          { elements = { { id = 'scopes', size = 0.25 }, 'breakpoints', 'stacks', 'watches' }, size = 40, position = 'left' },
          { elements = { 'repl', 'console' }, size = 0.25, position = 'bottom' },
        },
        controls = { enabled = true, element = 'repl' },
      }

      require('nvim-dap-virtual-text').setup()

      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<S-F11>', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<S-F5>', dap.terminate, { desc = 'Debug: Stop' })
      vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: Toggle UI' })

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  },
  -- vim-visual-multi (multi-cursor like VSCode)
  {
    'mg979/vim-visual-multi',
    branch = 'master',
    init = function()
      vim.g.VM_leader = '\\'
      vim.g.VM_default_mappings = 1
      vim.g.VM_maps = {
        ['Add Cursor Down'] = '<C-Down>',
        ['Add Cursor Up'] = '<C-Up>',
        ['Add Cursor At Pos'] = '<C-CR>',
        ['Find Under'] = '<C-D>',
        ['Find Subword Under'] = '<C-D>',
      }
    end,
    keys = {
      { '<C-D>', mode = { 'n', 'x' }, desc = 'Add next cursor (VSCode)' },
      { '<D-D>', mode = { 'n', 'x' }, desc = 'Add next cursor (macOS)' },
      { '<C-Down>', mode = { 'n', 'x' }, desc = 'Add cursor down' },
      { '<C-Up>', mode = { 'n', 'x' }, desc = 'Add cursor up' },
      { '<C-CR>', mode = { 'n', 'x' }, desc = 'Add cursor at pos' },
    },
  },
  -- outline (VSCode outline panel) — maintained fork of symbols-outline.
  -- The original simrat39/symbols-outline.nvim breaks on Neovim 0.11+
  -- (vim.treesitter.get_parser arity change); this fork fixes it.
  {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = { 'Outline', 'OutlineOpen' },
    keys = {
      { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle Outline' },
    },
    opts = {
      outline_window = { position = 'right', width = 25, relative_width = true },
      outline_items = { show_cursorline = true, highlight_hovered_item = true },
      guides = { enabled = true, markers = { bottom = '└', middle = '├', vertical = '│', horizontal = '─' } },
      keymaps = {
        close = { 'q' },
        goto_location = '<CR>',
        peek_location = 'o',
        goto_and_close = '<S-CR>',
        move_down = 'j',
        move_up = 'k',
        fold = 'zc',
        unfold = 'zo',
        fold_toggle = { '<tab>', 'za' },
        fold_all = 'zM',
        unfold_all = 'zR',
        reset_open_folds = 'R',
        fold_toggle_all = { 'zm' },
      },
    },
  },
}
