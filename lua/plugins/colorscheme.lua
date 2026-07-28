return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup { styles = { comments = { italic = false } } }
    end,
  },
  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
    config = function()
      require('vscode').setup { transparent = false, italic_comments = true, disable_nvimtree_bg = true }
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        term_colors = true,
        styles = { comments = { 'italic' }, conditionals = { 'italic' } },
        integrations = { cmp = true, gitsigns = true, telescope = true, treesitter = true, mason = true, which_key = true },
      }
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup {
        terminal_colors = true, undercurl = true, bold = true,
        italic = { strings = false, emphasis = true, comments = true, operators = false, folds = true },
      }
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
  {
    'Mofiqul/dracula.nvim',
    priority = 1000,
    config = function()
      require('dracula').setup { transparent_bg = false, italic_comment = true }
    end,
  },
  {
    'shaunsingh/nord.nvim',
    priority = 1000,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = true
      vim.g.nord_italic = true
    end,
  },
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'dark', transparent = false, term_colors = true,
        code_style = { comments = 'italic', keywords = 'none', functions = 'none', strings = 'none', variables = 'none' },
      }
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        undercurl = true, commentStyle = { italic = true }, keywordStyle = { italic = true },
        statementStyle = { bold = true }, transparent = false, terminalColors = true, theme = 'wave',
      }
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    config = function()
      require('nightfox').setup {
        options = {
          transparent = false, terminal_colors = true,
          styles = { comments = 'italic', keywords = 'bold', types = 'italic,bold' },
        },
      }
    end,
  },
  {
    'marko-cerovac/material.nvim',
    priority = 1000,
    config = function()
      require('material').setup {
        styles = { comments = { italic = true } },
        plugins = { 'gitsigns', 'indent-blankline', 'nvim-web-devicons', 'telescope', 'trouble', 'which-key' },
      }
    end,
  },
  -- Theme switching keymaps
  {
    dir = vim.fn.stdpath('config'),
    name = 'theme-utils',
    config = function()
      local function switch_theme(name)
        local ok = pcall(vim.cmd.colorscheme, name)
        if ok then vim.notify('Theme: ' .. name) end
      end
      vim.keymap.set('n', '<leader>tt', function()
        require('telescope.builtin').colorscheme({ enable_preview = true })
      end, { desc = 'Theme picker' })
      vim.keymap.set('n', '<leader>tv', function() switch_theme('vscode') end, { desc = 'VSCode theme' })
      vim.keymap.set('n', '<leader>to', function() switch_theme('tokyonight') end, { desc = 'Tokyo Night theme' })
      vim.keymap.set('n', '<leader>tc', function() switch_theme('catppuccin') end, { desc = 'Catppuccin theme' })
      vim.keymap.set('n', '<leader>tg', function() switch_theme('gruvbox') end, { desc = 'Gruvbox theme' })
      vim.keymap.set('n', '<leader>tD', function() switch_theme('dracula') end, { desc = 'Dracula theme' })
      vim.keymap.set('n', '<leader>tn', function() switch_theme('nord') end, { desc = 'Nord theme' })
    end,
  },
}
