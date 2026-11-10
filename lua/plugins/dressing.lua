return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  opts = {
    input = { enabled = false },
    select = {
      backend = { 'telescope', 'builtin' },
    },
  },
  config = function(_, opts)
    require('dressing').setup(opts)
    -- dressing always wraps `vim.ui.input`, even with `input.enabled = false`
    -- (the wrapper just delegates to the previous implementation). Snacks
    -- installs a nicer input UI, so put it back after dressing patches. This
    -- keeps `vim.ui.select` from dressing/telescope and `vim.ui.input` from
    -- Snacks, and keeps `:checkhealth snacks` green.
    pcall(function()
      require('snacks.input').enable()
    end)
  end,
}
