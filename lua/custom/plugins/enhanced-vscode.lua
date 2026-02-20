--- Enhanced VSCode-like features for Neovim
--- This module provides advanced VSCode-style functionality including:
--- - Project management with automatic detection
--- - Enhanced file explorer (Neo-tree)
--- - Advanced search and replace (Spectre)
--- - Integrated terminal (ToggleTerm)
--- - Multi-cursor support
--- - Minimap for code overview
--- @module enhanced-vscode

return {
  --- Advanced project/workspace management
  --- Provides automatic project detection and switching functionality
  --- similar to VSCode's workspace management
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup({
        manual_mode = false,
        detection_methods = { 'lsp', 'pattern' },
        patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', 'Cargo.toml', 'go.mod', 'build.zig' },
        ignore_lsp = {},
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = 'global',
      })
      
      -- Integration with telescope
      require('telescope').load_extension('projects')
      
      -- Keybinding for project switching (using <leader>pp to avoid conflict with Command Palette)
      -- VSCode: Ctrl+Shift+P > "Switch Project", here we use <leader>pp
      vim.keymap.set('n', '<leader>pp', function()
        require('telescope').extensions.projects.projects{}
      end, { desc = '[P]roject Switcher' })
    end,
  },

  --- Advanced file explorer with VSCode-like sidebar
  --- Neo-tree provides a powerful file explorer with:
  --- - Git status integration
  --- - Diagnostic markers
  --- - File operations (create, delete, rename, move)
  --- - Beautiful icons and visual indicators
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    lazy = false, -- Load immediately to ensure it's available
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<C-b>', ':Neotree toggle<CR>', desc = 'Toggle file explorer', silent = true },
      { '<C-S-e>', ':Neotree toggle<CR>', desc = 'Toggle file explorer', silent = true },
    },
    config = function()
      require('neo-tree').setup({
        close_if_last_window = true,
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = false,
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = '│',
            last_indent_marker = '└',
            highlight = 'NeoTreeIndentMarker',
            with_expanders = nil,
            expander_collapsed = '',
            expander_expanded = '',
            expander_highlight = 'NeoTreeExpander',
          },
          icon = {
            folder_closed = '',
            folder_open = '',
            folder_empty = 'ﰊ',
            default = '*',
            highlight = 'NeoTreeFileIcon'
          },
          modified = {
            symbol = '[+]',
            highlight = 'NeoTreeModified',
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = 'NeoTreeFileName',
          },
          git_status = {
            symbols = {
              added     = '',
              modified  = '',
              deleted   = '✖',
              renamed   = '',
              untracked = '',
              ignored   = '',
              unstaged  = '',
              staged    = '',
              conflict  = '',
            }
          },
        },
        window = {
          position = 'left',
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ['<space>'] = {
              'toggle_node',
              nowait = false,
            },
            ['<2-LeftMouse>'] = 'open',
            ['<cr>'] = 'open',
            ['<esc>'] = 'revert_preview',
            ['P'] = { 'toggle_preview', config = { use_float = true } },
            ['l'] = 'focus_preview',
            ['S'] = 'open_split',
            ['s'] = 'open_vsplit',
            ['t'] = 'open_tabnew',
            ['w'] = 'open_with_window_picker',
            ['C'] = 'close_node',
            ['z'] = 'close_all_nodes',
            ['a'] = {
              'add',
              config = {
                show_path = 'none'
              }
            },
            ['A'] = 'add_directory',
            ['d'] = 'delete',
            ['r'] = 'rename',
            ['y'] = 'copy_to_clipboard',
            ['x'] = 'cut_to_clipboard',
            ['p'] = 'paste_from_clipboard',
            ['c'] = 'copy',
            ['m'] = 'move',
            ['q'] = 'close_window',
            ['R'] = 'refresh',
            ['?'] = 'show_help',
            ['<'] = 'prev_source',
            ['>'] = 'next_source',
          }
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true,
            hide_by_name = {
              'node_modules'
            },
            hide_by_pattern = {
              '*.meta',
              '*/src/*/tsconfig.json',
            },
            always_show = {
              '.gitignored',
            },
            never_show = {
              '.DS_Store',
              'thumbs.db'
            },
            never_show_by_pattern = {
              '.null-ls_*',
            },
          },
          follow_current_file = {
            enabled = false,
            leave_dirs_open = false,
          },
          group_empty_dirs = false,
          hijack_netrw_behavior = 'open_default',
          use_libuv_file_watcher = false,
          window = {
            mappings = {
              ['<bs>'] = 'navigate_up',
              ['.'] = 'set_root',
              ['H'] = 'toggle_hidden',
              ['/'] = 'fuzzy_finder',
              ['D'] = 'fuzzy_finder_directory',
              ['#'] = 'fuzzy_sorter',
              ['f'] = 'filter_on_submit',
              ['<c-x>'] = 'clear_filter',
              ['[g'] = 'prev_git_modified',
              [']g'] = 'next_git_modified',
            }
          }
        },
        buffers = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          group_empty_dirs = true,
          show_unloaded = true,
          window = {
            mappings = {
              ['bd'] = 'buffer_delete',
              ['<bs>'] = 'navigate_up',
              ['.'] = 'set_root',
            }
          },
        },
        git_status = {
          window = {
            position = 'float',
            mappings = {
              ['A']  = 'git_add_all',
              ['gu'] = 'git_unstage_file',
              ['ga'] = 'git_add_file',
              ['gr'] = 'git_revert_file',
              ['gc'] = 'git_commit',
              ['gp'] = 'git_push',
              ['gg'] = 'git_commit_and_push',
            }
          }
        }
      })
    end,
  },

  -- Enhanced terminal integration with more VSCode-like features
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup({
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-`>]],
        hide_numbers = true,
        shade_filetypes = {},
        autochdir = false,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = 'curved',
          width = function()
            return math.ceil(vim.o.columns * 0.8)
          end,
          height = function()
            return math.ceil(vim.o.lines * 0.8)
          end,
          winblend = 0,
        },
        winbar = {
          enabled = false,
          name_formatter = function(term)
            return term.name
          end
        },
      })

      -- Terminal keybindings (VSCode-like)
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      -- VSCode-like terminal shortcuts
      vim.keymap.set('n', '<C-S-`>', function()
        vim.cmd('ToggleTerm direction=horizontal')
      end, { desc = 'Toggle horizontal terminal' })

      vim.keymap.set('n', '<leader>tf', function()
        vim.cmd('ToggleTerm direction=float')
      end, { desc = 'Toggle floating terminal' })

      vim.keymap.set('n', '<leader>tv', function()
        vim.cmd('ToggleTerm direction=vertical')
      end, { desc = 'Toggle vertical terminal' })

      vim.keymap.set('n', '<leader>th', function()
        vim.cmd('ToggleTerm direction=horizontal')
      end, { desc = 'Toggle horizontal terminal' })
    end,
  },

  -- Enhanced debugging support (like VSCode's debugging)
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      require('mason-nvim-dap').setup({
        automatic_setup = true,
        handlers = {},
        ensure_installed = {
          'delve',      -- Go debugger
          'python',     -- Python debugger
          'js-debug-adapter', -- JavaScript debugger
          'codelldb',   -- C/C++/Rust debugger
        },
      })

      dapui.setup({
        icons = { expanded = '', collapsed = '', current_frame = '' },
        mappings = {
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          edit = 'e',
          repl = 'r',
          toggle = 't',
        },
        element_mappings = {},
        expand_lines = vim.fn.has('nvim-0.7') == 1,
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.25 },
              'breakpoints',
              'stacks',
              'watches',
            },
            size = 40,
            position = 'left',
          },
          {
            elements = {
              'repl',
              'console',
            },
            size = 0.25,
            position = 'bottom',
          },
        },
        controls = {
          enabled = true,
          element = 'repl',
          icons = {
            pause = '',
            play = '',
            step_into = '',
            step_over = '',
            step_out = '',
            step_back = '',
            run_last = '',
            terminate = '',
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = 'single',
          mappings = {
            close = { 'q', '<Esc>' },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil,
          max_value_lines = 100,
        }
      })

      require('nvim-dap-virtual-text').setup()

      -- VSCode-like debugging keybindings
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<S-F11>', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<S-F5>', dap.terminate, { desc = 'Debug: Stop' })
      vim.keymap.set('n', '<C-S-F5>', dap.restart, { desc = 'Debug: Restart' })

      -- Toggle UI
      vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: See last session result.' })

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  },

  -- Enhanced Git integration (like VSCode's Git features)
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('neogit').setup({
        disable_signs = false,
        disable_hint = false,
        disable_context_highlighting = false,
        disable_commit_confirmation = false,
        auto_refresh = true,
        disable_builtin_notifications = false,
        use_magit_keybindings = false,
        commit_popup = {
          kind = 'split',
        },
        popup = {
          kind = 'split',
        },
        signs = {
          section = { '', '' },
          item = { '', '' },
          hunk = { '', '' },
        },
        integrations = {
          diffview = true
        },
      })

      -- VSCode-like Git shortcuts
      vim.keymap.set('n', '<C-S-g>', '<cmd>Neogit<CR>', { desc = 'Open Git (Source Control)' })
      vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<CR>', { desc = 'Open Neogit' })
      vim.keymap.set('n', '<leader>gc', '<cmd>Neogit commit<CR>', { desc = 'Git commit' })
      vim.keymap.set('n', '<leader>gp', '<cmd>Neogit push<CR>', { desc = 'Git push' })
      vim.keymap.set('n', '<leader>gl', '<cmd>Neogit pull<CR>', { desc = 'Git pull' })
    end,
  },

  -- Outline panel (like VSCode's outline)
  {
    'simrat39/symbols-outline.nvim',
    config = function()
      require('symbols-outline').setup({
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false,
        position = 'right',
        relative_width = true,
        width = 25,
        auto_close = false,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = 'Pmenu',
        autofold_depth = nil,
        auto_unfold_hover = true,
        fold_markers = { '', '' },
        wrap = false,
        keymaps = {
          close = { '<Esc>', 'q' },
          goto_location = '<Cr>',
          focus_location = 'o',
          hover_symbol = '<C-space>',
          toggle_preview = 'K',
          rename_symbol = 'r',
          code_actions = 'a',
          fold = 'h',
          unfold = 'l',
          fold_all = 'W',
          unfold_all = 'E',
          fold_reset = 'R',
        },
        lsp_blacklist = {},
        symbol_blacklist = {},
        symbols = {
          File = { icon = '', hl = '@text.uri' },
          Module = { icon = '', hl = '@namespace' },
          Namespace = { icon = '', hl = '@namespace' },
          Package = { icon = '', hl = '@namespace' },
          Class = { icon = '𝓒', hl = '@type' },
          Method = { icon = 'ƒ', hl = '@method' },
          Property = { icon = '', hl = '@method' },
          Field = { icon = '', hl = '@field' },
          Constructor = { icon = '', hl = '@constructor' },
          Enum = { icon = 'ℰ', hl = '@type' },
          Interface = { icon = 'ﰮ', hl = '@type' },
          Function = { icon = '', hl = '@function' },
          Variable = { icon = '', hl = '@constant' },
          Constant = { icon = '', hl = '@constant' },
          String = { icon = '𝓐', hl = '@string' },
          Number = { icon = '#', hl = '@number' },
          Boolean = { icon = '⊨', hl = '@boolean' },
          Array = { icon = '', hl = '@constant' },
          Object = { icon = '⦿', hl = '@type' },
          Key = { icon = '🔐', hl = '@type' },
          Null = { icon = 'NULL', hl = '@type' },
          EnumMember = { icon = '', hl = '@field' },
          Struct = { icon = '𝓢', hl = '@type' },
          Event = { icon = '🗲', hl = '@type' },
          Operator = { icon = '+', hl = '@operator' },
          TypeParameter = { icon = '𝙏', hl = '@parameter' },
          Component = { icon = '', hl = '@function' },
          Fragment = { icon = '', hl = '@constant' },
        },
      })

      -- VSCode-like outline toggle
      vim.keymap.set('n', '<C-S-o>', '<cmd>SymbolsOutline<CR>', { desc = 'Toggle Symbols Outline' })
    end,
  },

  -- Better workspace search and replace
  {
    'nvim-pack/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('spectre').setup({
        color_devicons = true,
        highlight = {
          ui = 'String',
          search = 'DiffChange',
          replace = 'DiffDelete'
        },
        mapping = {
          ['toggle_line'] = {
            map = 'dd',
            cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
            desc = 'toggle current item',
          },
          ['enter_file'] = {
            map = '<cr>',
            cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
            desc = 'goto current file',
          },
          ['send_to_qf'] = {
            map = '<leader>q',
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = 'send all items to quickfix',
          },
          ['replace_cmd'] = {
            map = '<leader>c',
            cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
            desc = 'input replace command',
          },
          ['show_option_menu'] = {
            map = '<leader>o',
            cmd = "<cmd>lua require('spectre').show_options()<CR>",
            desc = 'show options',
          },
          ['run_current_replace'] = {
            map = '<leader>rc',
            cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
            desc = 'replace current line',
          },
          ['run_replace'] = {
            map = '<leader>R',
            cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
            desc = 'replace all',
          },
          ['change_view_mode'] = {
            map = '<leader>v',
            cmd = "<cmd>lua require('spectre').change_view()<CR>",
            desc = 'change result view mode',
          },
          ['change_replace_sed'] = {
            map = 'trs',
            cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
            desc = 'use sed to replace',
          },
          ['change_replace_oxi'] = {
            map = 'tro',
            cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
            desc = 'use oxi to replace',
          },
          ['toggle_live_update'] = {
            map = 'tu',
            cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
            desc = 'update when vim writes to file',
          },
          ['toggle_ignore_case'] = {
            map = 'ti',
            cmd = "<cmd>lua require('spectre').toggle_ignore_case()<CR>",
            desc = 'toggle ignore case',
          },
          ['toggle_ignore_hidden'] = {
            map = 'th',
            cmd = "<cmd>lua require('spectre').toggle_ignore_hidden()<CR>",
            desc = 'toggle search hidden',
          },
          ['resume_last_search'] = {
            map = '<leader>l',
            cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
            desc = 'resume last search before close',
          },
        },
        find_engine = {
          ['rg'] = {
            cmd = 'rg',
            args = {
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
            },
            options = {
              ['ignore-case'] = {
                value = '--ignore-case',
                icon = '[I]',
                desc = 'ignore case',
              },
              ['hidden'] = {
                value = '--hidden',
                desc = 'hidden file',
                icon = '[H]',
              },
            },
          },
        },
        replace_engine = {
          ['sed'] = {
            cmd = 'sed',
            args = nil,
            options = {
              ['ignore-case'] = {
                value = '--ignore-case',
                icon = '[I]',
                desc = 'ignore case',
              },
            },
          },
        },
        default = {
          find = {
            cmd = 'rg',
            options = { 'ignore-case' },
          },
          replace = {
            cmd = 'sed',
          },
        },
        replace_vim_cmd = 'cdo',
        is_open = false,
        is_insert_mode = false,
      })

      -- Enhanced VSCode-like search keybindings
      vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
        desc = 'Toggle Spectre'
      })
      vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
        desc = 'Search current word'
      })
      vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
        desc = 'Search current word'
      })
      vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
        desc = 'Search on current file'
      })
    end,
  },

  -- Enhanced notifications (like VSCode's notifications)
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({
        background_colour = '#000000',
        fps = 30,
        icons = {
          DEBUG = '',
          ERROR = '',
          INFO = '',
          TRACE = '✎',
          WARN = '',
        },
        level = 2,
        minimum_width = 50,
        render = 'default',
        stages = 'fade_in_slide_out',
        timeout = 5000,
        top_down = true,
      })
      vim.notify = require('notify')
    end,
  },

  -- Task runner (like VSCode's tasks)
  {
    'stevearc/overseer.nvim',
    config = function()
      require('overseer').setup({
        templates = { 'builtin', 'user.cpp_build', 'user.run_script' },
        strategy = {
          'toggleterm',
          direction = 'horizontal',
          autos_scroll = true,
          quit_on_exit = 'success'
        },
        component_aliases = {
          default = {
            { 'display_duration', detail_level = 2 },
            'on_output_summarize',
            'on_exit_set_status',
            'on_complete_notify',
            'on_complete_dispose',
          },
        },
      })

      -- VSCode-like task shortcuts
      vim.keymap.set('n', '<C-S-t>', '<cmd>OverseerToggle<CR>', { desc = 'Toggle task list' })
      vim.keymap.set('n', '<leader>or', '<cmd>OverseerRun<CR>', { desc = 'Run task' })
      vim.keymap.set('n', '<leader>ot', '<cmd>OverseerToggle<CR>', { desc = 'Toggle task list' })
      vim.keymap.set('n', '<leader>oa', '<cmd>OverseerTaskAction<CR>', { desc = 'Task action' })
    end,
  },
}