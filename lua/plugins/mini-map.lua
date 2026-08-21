return {
  'echasnovski/mini.map',
  version = false,
  keys = {
    { '<leader>mm', function() require('mini.map').toggle() end, desc = 'Toggle minimap' },
  },
  opts = {
    symbols = { encode = require('mini.map').gen_encode_symbols.block() },
    integrations = {
      require('mini.map').gen_integration.diagnostic(),
      require('mini.map').gen_integration.builtin_search(),
      require('mini.map').gen_integration.gitsigns(),
      require('mini.map').gen_integration.diff(),
    },
    window = {
      side = 'right',
      width = 20,
      show_integration_count = true,
      zindex = 2,
    },
  },
  config = function(_, opts)
    require('mini.map').setup(opts)
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(event)
        local ignored = {
          'neo-tree', 'telescope', 'dashboard', 'lazy', 'mason', 'checkhealth',
          'noice', 'codediff-explorer', 'codediff-history', 'spectre',
          'toggleterm', 'prompt', 'qf', 'help',
        }
        if vim.tbl_contains(ignored, vim.bo[event.buf].filetype) then
          require('mini.map').close(event.buf)
        end
      end,
    })
  end,
}