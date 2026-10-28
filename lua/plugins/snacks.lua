return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dim = { enabled = true },
    image = { enabled = not vim.g.neovide },
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = {
      enabled = true,
      animate = { duration = { step = 30, total = 200 } },
    },
    words = { enabled = true },
    zen = { enabled = true },
  },
  keys = {
    { '<leader>lg', function() Snacks.lazygit() end, desc = 'Lazygit' },
    { '<leader>un', function() Snacks.notifier.show_history() end, desc = 'Notification history' },
    { '<leader>uN', function() Snacks.notifier.hide() end, desc = 'Dismiss notifications' },
    { '<leader>uz', function() Snacks.zen() end, desc = 'Zen mode' },
    { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next reference', mode = { 'n', 't' } },
    { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev reference', mode = { 'n', 't' } },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        Snacks.toggle.dim():map('<leader>uD')
      end,
    })
  end,
}