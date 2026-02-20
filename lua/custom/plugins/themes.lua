--- Theme Configuration for 0xVim
--- This module provides multiple color schemes for Neovim with easy switching
--- Available themes include:
--- - VSCode (default)
--- - Tokyo Night (multiple variants)
--- - Catppuccin (multiple flavors)
--- - Dracula
--- - Nord
--- - Gruvbox
--- - One Dark
--- - Kanagawa
--- @module themes

return {
  --- VSCode theme - provides authentic VSCode color scheme
  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
    config = function()
      require('vscode').setup {
        transparent = false,
        italic_comments = true,
        disable_nvimtree_bg = true,
      }
    end,
  },

  --- Tokyo Night theme - beautiful night theme with multiple variants
  --- Variants: night, storm, day, moon
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        style = 'night', -- The theme comes in three styles: storm, moon, night, day
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = 'dark',
          floats = 'dark',
        },
      })
    end,
  },

  --- Catppuccin theme - soothing pastel theme
  --- Flavors: latte, frappe, macchiato, mocha
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = false,
          shade = 'dark',
          percentage = 0.15,
        },
        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
          mason = true,
          which_key = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
        },
      })
    end,
  },

  --- Dracula theme - dark theme inspired by Dracula
  {
    'Mofiqul/dracula.nvim',
    priority = 1000,
    config = function()
      require('dracula').setup({
        transparent_bg = false,
        italic_comment = true,
      })
    end,
  },

  --- Nord theme - arctic, north-bluish color palette
  {
    'shaunsingh/nord.nvim',
    priority = 1000,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = true
      vim.g.nord_disable_background = false
      vim.g.nord_italic = true
      vim.g.nord_uniform_diff_background = true
    end,
  },

  --- Gruvbox theme - retro groove color scheme
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        contrast = '', -- can be "hard", "soft" or empty string
        transparent_mode = false,
      })
    end,
  },

  --- OneDark theme - Atom's iconic One Dark theme
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'dark', -- Options: dark, darker, cool, deep, warm, warmer, light
        transparent = false,
        term_colors = true,
        ending_tildes = false,
        code_style = {
          comments = 'italic',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none',
        },
      }
    end,
  },

  --- Kanagawa theme - inspired by the colors of the famous painting
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        theme = 'wave', -- Load "wave" theme when 'background' option is not set
      })
    end,
  },

  --- Nightfox theme - highly customizable theme with multiple variants
  --- Variants: nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    config = function()
      require('nightfox').setup({
        options = {
          transparent = false,
          terminal_colors = true,
          dim_inactive = false,
          styles = {
            comments = 'italic',
            keywords = 'bold',
            types = 'italic,bold',
          },
        },
      })
    end,
  },

  --- Rose Pine theme - all natural pine, faux fur and a bit of soho vibes
  --- Variants: main, moon, dawn
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require('rose-pine').setup({
        variant = 'main', -- auto, main, moon, or dawn
        dark_variant = 'main',
        dim_inactive_windows = false,
        extend_background_behind_borders = true,
        styles = {
          bold = true,
          italic = true,
          transparency = false,
        },
      })
    end,
  },

  --- Material theme - Material Design color palette
  --- Styles: darker, lighter, oceanic, palenight, deep ocean
  {
    'marko-cerovac/material.nvim',
    priority = 1000,
    config = function()
      require('material').setup({
        contrast = {
          terminal = false,
          sidebars = false,
          floating_windows = false,
          cursor_line = false,
          non_current_windows = false,
          filetypes = {},
        },
        styles = {
          comments = { italic = true },
          strings = { },
          keywords = { },
          functions = { },
          variables = { },
          operators = { },
          types = { },
        },
        plugins = {
          'gitsigns',
          'indent-blankline',
          'nvim-cmp',
          'nvim-web-devicons',
          'telescope',
          'trouble',
          'which-key',
        },
        disable = {
          colored_cursor = false,
          borders = false,
          background = false,
          term_colors = false,
          eob_lines = false,
        },
        lualine_style = 'default', -- default, stealth, or 'default'
      })
    end,
  },
}
