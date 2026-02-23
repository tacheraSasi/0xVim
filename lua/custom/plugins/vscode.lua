--- VSCode-like plugin configuration for 0xVim
--- This module provides a comprehensive VSCode experience including:
--- - VSCode color scheme
--- - Status line (lualine)
--- - Integrated terminal (toggleterm)
--- - Indentation guides
--- - Auto-pairs
--- - Git integration
--- - Search and replace (Spectre)
--- - Multi-cursor support
--- - Comment toggling
--- - Zen mode
--- - Code folding
--- - Diagnostics panel (Trouble)
--- @module custom.plugins.vscode

return {
  -- NOTE: VSCode color scheme is configured in themes.lua
  -- NOTE: neo-tree configuration is in enhanced-vscode.lua

  --- Better status line (like VSCode's status bar)
  --- Shows file info, git status, diagnostics, and cursor position
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
            { 'filename',         path = 1 },                  -- Show relative path
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

  -- NOTE: Integrated terminal (toggleterm) configuration is in enhanced-vscode.lua

  --- Indentation guides (like VSCode's indent guides)
  --- Visual vertical lines showing indentation levels
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

  --- Auto-pairs (like VSCode's auto-pairing)
  --- Automatically closes brackets, quotes, and other pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true,                      -- Use treesitter to check for pairs
        ts_config = {
          lua = { 'string' },                 -- Don't add pairs in lua string treesitter nodes
          javascript = { 'template_string' }, -- Don't add pairs in javascript template_string
        },
      }
    end,
  },

  -- NOTE: gitsigns configuration is in init.lua (main kickstart config)
  -- NOTE: spectre configuration is in enhanced-vscode.lua

  --- Multi-cursor support (like VSCode's multi-cursor)
  --- Enables editing multiple locations simultaneously
  {
    'mg979/vim-visual-multi',
    branch = 'master',
  },

  --- Comment plugin for VSCode-like commenting
  --- Toggle line and block comments easily
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = function()
      require('Comment').setup({
        --- NOTE: Keybindings are configured in lua/custom/vscode-keybindings.lua
        --- to maintain consistency with other VSCode-like keybindings
        toggler = {
          line = 'gcc', -- Use default vim-style for toggler
          block = 'gbc',
        },
        opleader = {
          line = 'gc',
          block = 'gb',
        },
        -- Disable extra mappings to avoid conflicts with our custom keybindings
        mappings = {
          basic = true,
          extra = false,
        },
      })
    end,
  },

  --- Zen mode for distraction-free coding
  --- Removes UI elements for focused coding sessions
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

  --- Twilight (dims inactive code)
  --- Works with Zen mode to highlight only the active code
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

  --- Breadcrumbs navigation
  --- Shows code structure in the status bar (file > class > method)
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

  --- Minimap for code overview
  --- Provides a bird's-eye view of your code (like VSCode minimap)
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

  --- Better code folding with preview
  --- Uses treesitter for intelligent code folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    event = 'BufReadPost',
    config = function()
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
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
              table.insert(newVirtText, { chunkText, hlGroup })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          table.insert(newVirtText, { suffix, 'MoreMsg' })
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

  -- NOTE: Trouble.nvim configuration is in custom/plugins.lua
  -- NOTE: Neogit configuration is in enhanced-vscode.lua

  --- Git blame integration
  --- Shows git blame info inline in the editor
  {
    'f-person/git-blame.nvim',
    config = function()
      vim.g.gitblame_enabled = 1        -- Enabled by default
      vim.g.gitblame_message_template = '<author> • <date> • <summary>'
      vim.g.gitblame_date_format = '%r' -- Relative time (e.g. "3 days ago")
      vim.g.gitblame_highlight_group = 'Comment'

      vim.keymap.set('n', '<leader>gb', '<Cmd>GitBlameToggle<CR>', { desc = 'Toggle [G]it [B]lame' })
    end,
  },
  --- Conform - Formatter plugin with format-on-save
  --- Automatically formats code on save
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

  --- nvim-lint - Linting integration for Neovim
  --- Provides real-time linting for various languages
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
