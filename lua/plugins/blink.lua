return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 and nil or 'make install_jsregexp',
      dependencies = { 'rafamadriz/friendly-snippets' },
    },
    'folke/lazydev.nvim',
  },
  opts = {
    keymap = { preset = 'default' },
    appearance = { nerd_font_variant = 'mono' },
    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 1000, window = { border = 'rounded' } },
      menu = { border = 'rounded', draw = { treesitter = { 'lsp' }, columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' } } } },
      trigger = { prefetch_on_insert = false, show_in_snippet = true, show_on_keyword = true },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = { lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 } },
    },
    cmdline = { sources = { default = { 'path', 'cmdline' } } },
    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'lua' },
    signature = { enabled = true, window = { border = 'rounded' } },
  },
}
