return {
  'nvim-neotest/neotest',
  event = 'VeryLazy',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'olimorris/neotest-phpunit',
    'haydenmeade/neotest-jest',
    'fredrikaverpil/neotest-golang',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require('neotest-phpunit'),
        require('neotest-jest'),
        require('neotest-golang'),
      },
    }
  end,
  keys = {
    { '<leader>nt', function() require('neotest').run.run() end, desc = 'Test: nearest' },
    { '<leader>nT', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Test: file' },
    { '<leader>nR', function() require('neotest').run.run(vim.fn.getcwd()) end, desc = 'Test: all' },
    { '<leader>ns', function() require('neotest').summary.toggle() end, desc = 'Test: summary' },
    { '<leader>no', function() require('neotest').output.open({ enter = true }) end, desc = 'Test: output' },
  },
}