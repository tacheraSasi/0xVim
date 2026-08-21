return {
  'gbprod/yanky.nvim',
  keys = {
    { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put after cursor' },
    { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put before cursor' },
    { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put after, leave cursor' },
    { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put before, leave cursor' },
    { 'gy', '<Plug>(YankyPreviousEntry)', desc = 'Yank ring: previous entry' },
    { 'gY', '<Plug>(YankyNextEntry)', desc = 'Yank ring: next entry' },
    { '<leader>uy', '<cmd>YankyRingHistory<CR>', desc = 'Yank history' },
  },
  opts = {
    ring = {
      history_length = 100,
      storage = 'shada',
      sync_with_numbered_registers = true,
    },
    highlight = { on_put = true, on_yank = true, timer = 500 },
    system_clipboard = { sync_with_ring = true },
  },
  config = function(_, opts)
    require('yanky').setup(opts)
    pcall(require('telescope').load_extension, 'yank_history')
  end,
}