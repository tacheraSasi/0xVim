return {
  -- navic (breadcrumbs)
  {
    'SmiteshP/nvim-navic',
    dependencies = 'neovim/nvim-lspconfig',
    opts = { highlight = false, separator = ' > ', depth_limit = 0, safe_output = true },
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
    dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
    config = function()
      require('neogit').setup {
        disable_signs = false, disable_hint = false, disable_context_highlighting = false,
        disable_commit_confirmation = false, auto_refresh = true, use_magit_keybindings = false,
        integrations = { diffview = true },
      }
      vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<CR>', { desc = 'Open Neogit' })
      vim.keymap.set('n', '<leader>gc', '<cmd>Neogit commit<CR>', { desc = 'Git commit' })
      vim.keymap.set('n', '<leader>gp', '<cmd>Neogit push<CR>', { desc = 'Git push' })
      vim.keymap.set('n', '<leader>gl', '<cmd>Neogit pull<CR>', { desc = 'Git pull' })
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
        ensure_installed = { 'delve', 'codelldb' },
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
  -- symbols-outline (VSCode outline panel)
  {
    'simrat39/symbols-outline.nvim',
    config = function()
      require('symbols-outline').setup {
        highlight_hovered_item = true, show_guides = true, auto_preview = false,
        position = 'right', width = 25, auto_close = false,
      }
      vim.keymap.set('n', '<leader>o', '<cmd>SymbolsOutline<CR>', { desc = 'Toggle Outline' })
    end,
  },
}
