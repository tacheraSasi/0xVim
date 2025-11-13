return {
  -- VSCode-like color scheme
  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
    config = function()
      require('vscode').setup {
        -- Enable transparent background
        transparent = false,
        -- Enable italic comments
        italic_comments = true,
        -- Disable nvim-tree background color
        disable_nvimtree_bg = true,
      }
      -- Set colorscheme after options
      vim.cmd.colorscheme 'vscode'
    end,
  },

  -- NOTE: neo-tree configuration moved to lua/custom/plugins/enhanced-vscode.lua
  -- to avoid conflicts and provide better VSCode-like experience

  -- Better status line (like VSCode's status bar)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
    config = function()
      local navic = require('nvim-navic')
      require('lualine').setup {
        options = {
          theme = 'vscode',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 
            { 'filename', path = 1 }, -- Show relative path
            { navic.get_location, cond = navic.is_available }, -- Breadcrumbs
          },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        winbar = {
          lualine_c = {
            { navic.get_location, cond = navic.is_available },
          },
        },
        inactive_winbar = {
          lualine_c = {
            { navic.get_location, cond = navic.is_available },
          },
        },
      }
    end,
  },

  -- Integrated terminal (like VSCode's integrated terminal)
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<C-`>]], -- Ctrl+` to toggle terminal (like VSCode)
        direction = 'float',
        float_opts = {
          border = 'curved',
        },
      }

      -- Terminal keybindings
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      -- Auto-command to set terminal keymaps when terminal opens
      vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'
    end,
  },

  -- Indentation guides (like VSCode's indent guides)
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('ibl').setup {
        indent = {
          char = '│', -- Use a continuous line for indentation
        },
        scope = { enabled = true },
      }
    end,
  },

  -- Auto-pairs (like VSCode's auto-pairing)
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true, -- Use treesitter to check for pairs
        ts_config = {
          lua = { 'string' }, -- Don't add pairs in lua string treesitter nodes
          javascript = { 'template_string' }, -- Don't add pairs in javascript template_string
        },
      }
    end,
  },

  -- Git integration (like VSCode's git features)
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '│' },
          change = { text = '│' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          -- Navigation between hunks
          vim.keymap.set('n', ']c', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr })

          vim.keymap.set('n', '[c', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr })

          -- Actions
          vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
          vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr, desc = 'Reset hunk' })
          vim.keymap.set('n', '<leader>hb', function()
            gs.blame_line { full = true }
          end, { buffer = bufnr, desc = 'Blame line' })
          vim.keymap.set('n', '<leader>hd', gs.diffthis, { buffer = bufnr, desc = 'Diff this' })
          vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview hunk' })
        end,
      }
    end,
  },

  -- Better search and replace (like VSCode's search)
  {
    'nvim-pack/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('spectre').setup {
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
        },
      }

      -- Keybinding to open search and replace
      vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").open()<CR>', {
        desc = 'Open Spectre for search and replace',
      })
    end,
  },

  -- Multiple cursors (like VSCode's multi-cursor)
  {
    'mg979/vim-visual-multi',
    branch = 'master',
  },

  -- Comment plugin for VSCode-like commenting
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = function()
      require('Comment').setup({
        -- NOTE: Keybindings are configured in lua/custom/vscode-keybindings.lua
        -- to maintain consistency with other VSCode-like keybindings
        toggler = {
          line = 'gcc', -- Use default vim-style for toggler
          block = 'gbc',
        },
        opleader = {
          line = 'gc',
          block = 'gb',
        },
        -- Disable extra mappings to avoid conflicts
        extra = {
          above = false,
          below = false,
          eol = false,
        },
      })
    end,
  },

  -- Zen mode for distraction-free coding
  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    config = function()
      require('zen-mode').setup({
        window = {
          backdrop = 0.95,
          width = 120,
          height = 1,
          options = {
            signcolumn = "no",
            number = false,
            relativenumber = false,
            cursorline = false,
            cursorcolumn = false,
            foldcolumn = "0",
            list = false,
          },
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false,
            showcmd = false,
          },
          twilight = { enabled = true },
          gitsigns = { enabled = false },
          tmux = { enabled = false },
        },
      })
    end,
  },

  -- Twilight (dims inactive code)
  {
    'folke/twilight.nvim',
    cmd = 'Twilight',
    config = function()
      require('twilight').setup({
        dimming = {
          alpha = 0.25,
          color = { "Normal", "#ffffff" },
          term_bg = "#000000",
          inactive = false,
        },
        context = 10,
        treesitter = true,
      })
    end,
  },

  -- Breadcrumbs navigation
  {
    'SmiteshP/nvim-navic',
    dependencies = 'neovim/nvim-lspconfig',
    config = function()
      require('nvim-navic').setup({
        icons = {
          File = ' ',
          Module = ' ',
          Namespace = ' ',
          Package = ' ',
          Class = ' ',
          Method = ' ',
          Property = ' ',
          Field = ' ',
          Constructor = ' ',
          Enum = ' ',
          Interface = ' ',
          Function = ' ',
          Variable = ' ',
          Constant = ' ',
          String = ' ',
          Number = ' ',
          Boolean = ' ',
          Array = ' ',
          Object = ' ',
          Key = ' ',
          Null = ' ',
          EnumMember = ' ',
          Struct = ' ',
          Event = ' ',
          Operator = ' ',
          TypeParameter = ' ',
        },
        highlight = false,
        separator = " > ",
        depth_limit = 0,
        depth_limit_indicator = "..",
        safe_output = true,
      })
    end,
  },

  -- Minimap for code overview
  {
    'wfxr/minimap.vim',
    build = 'cargo install --locked code-minimap',
    cmd = { 'Minimap', 'MinimapClose', 'MinimapToggle', 'MinimapRefresh', 'MinimapUpdateHighlight' },
    config = function()
      vim.g.minimap_width = 10
      vim.g.minimap_auto_start = 0
      vim.g.minimap_auto_start_win_enter = 0
      vim.g.minimap_block_filetypes = { 'fugitive', 'nerdtree', 'tagbar' }
      vim.g.minimap_close_filetypes = { 'startify', 'netrw', 'vim-plug' }
      vim.g.minimap_highlight_search = 1
      vim.g.minimap_highlight_range = 1
      vim.g.minimap_git_colors = 1
      
      -- Keybinding to toggle minimap
      vim.keymap.set('n', '<leader>mm', ':MinimapToggle<CR>', { desc = 'Toggle Minimap' })
    end,
  },

  -- Better folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    event = 'BufReadPost',
    config = function()
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return {'treesitter', 'indent'}
        end,
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = (' 󰁂 %d '):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, {chunkText, hlGroup})
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          table.insert(newVirtText, {suffix, 'MoreMsg'})
          return newVirtText
        end,
      })

      -- Set up folding options
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Folding keymaps
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
      vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, { desc = 'Open folds except kinds' })
      vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, { desc = 'Close folds with' })
    end,
  },

  -- Problems/diagnostics panel
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('trouble').setup({
        mode = "workspace_diagnostics",
        auto_open = false,
        auto_close = true,
        auto_preview = true,
        auto_fold = false,
        auto_jump = {"lsp_definitions"},
        signs = {
          error = "󰅚",
          warning = "󰀪",
          hint = "󰌶",
          information = "󰋽",
          other = "󰌶",
        },
        use_diagnostic_signs = true,
      })

      -- Keybindings for trouble
      vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { desc = 'Toggle Trouble' })
      vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', { desc = 'Workspace Diagnostics' })
      vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', { desc = 'Document Diagnostics' })
      vim.keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', { desc = 'Location List' })
      vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', { desc = 'Quickfix List' })
      vim.keymap.set('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>', { desc = 'LSP References' })
    end,
  },
  {
    'f-person/git-blame.nvim',
    config = function()
      vim.g.gitblame_enabled = 1 -- Enable by default
      vim.g.gitblame_message_template = '<author> • <date> • <summary>'
      vim.g.gitblame_date_format = '%r' -- e.g. "3 days ago"
      vim.g.gitblame_highlight_group = 'Comment'

      -- Optional: Toggle Git blame
      vim.keymap.set('n', '<leader>gb', '<Cmd>GitBlameToggle<CR>', { desc = 'Toggle git blame' })
    end,
  },
  {
    'NeogitOrg/neogit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('neogit').setup {}
      vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<CR>', { desc = 'Open Neogit' })
    end,
  },
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup {
        format_on_save = {
          lsp_fallback = true,
        },
        formatters_by_ft = {
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          lua = { 'stylua' },
          python = { 'black' },
          zig = { 'zls' },
        },
      }
    end,
  },

  -- Linting (like VSCode's linting)
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- Configure linters for different filetypes
      lint.linters_by_ft = {
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        python = { 'flake8', 'mypy' },
        lua = { 'luacheck' },
        markdown = { 'markdownlint' },
        sh = { 'shellcheck' },
        bash = { 'shellcheck' },
        yaml = { 'yamllint' },
        json = { 'jsonlint' },
        dockerfile = { 'hadolint' },
      }

      -- Run linting when reading or writing a buffer, and on changes in insert and normal mode
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })

      -- Manual lint trigger
      vim.keymap.set('n', '<leader>l', function()
        lint.try_lint()
      end, { desc = 'Trigger linting for current file' })
    end,
  },
}
