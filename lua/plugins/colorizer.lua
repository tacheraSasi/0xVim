return {
  'NvChad/nvim-colorizer.lua',
  event = 'BufReadPost',
  opts = {
    filetypes = {
      'css', 'scss', 'less', 'html', 'javascript', 'typescript',
      'javascriptreact', 'typescriptreact', 'vue', 'svelte', 'php',
      'lua', 'python', 'rust', 'go', 'zig', 'json', 'yaml', 'markdown',
      'tailwind',
    },
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      names = true,
      RRGGBBAA = true,
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
      mode = 'background',
      tailwind = true,
      sass = { enable = false, parsers = { css = false } },
      always_update = false,
    },
    buftypes = {},
  },
  config = function(_, opts)
    require('colorizer').setup(opts)
    vim.keymap.set('n', '<leader>tc', '<cmd>ColorizerToggle<CR>', { desc = 'Toggle color preview' })
  end,
}
