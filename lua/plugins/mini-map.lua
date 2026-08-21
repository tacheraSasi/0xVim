return {
  'echasnovski/mini.map',
  version = false,
  keys = {
    { '<leader>mm', function() require('mini.map').toggle() end, desc = 'Toggle minimap' },
  },
  config = function()
    local MiniMap = require('mini.map')
    MiniMap.setup {
      symbols = { encode = MiniMap.gen_encode_symbols.block() },
      integrations = {
        MiniMap.gen_integration.diagnostic(),
        MiniMap.gen_integration.builtin_search(),
        MiniMap.gen_integration.gitsigns(),
        MiniMap.gen_integration.diff(),
      },
      window = {
        side = 'right',
        width = 20,
        show_integration_count = true,
        zindex = 2,
      },
    }
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(event)
        local ignored = {
          'neo-tree', 'telescope', 'dashboard', 'lazy', 'mason', 'checkhealth',
          'noice', 'codediff-explorer', 'codediff-history', 'spectre',
          'toggleterm', 'prompt', 'qf', 'help',
        }
        if vim.tbl_contains(ignored, vim.bo[event.buf].filetype) then
          MiniMap.close(event.buf)
        end
      end,
    })
  end,
}