return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  opts = {
    input = { enabled = false },
    select = {
      backend = { 'telescope', 'builtin' },
    },
  },
}