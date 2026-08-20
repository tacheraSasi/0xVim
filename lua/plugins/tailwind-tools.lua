return {
  'luckasRanarison/tailwind-tools.nvim',
  name = 'tailwind-tools',
  build = ':UpdateRemotePlugins',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    server = {
      override = false,
    },
    document_color = {
      enabled = true,
      kind = 'inline',
    },
  },
}