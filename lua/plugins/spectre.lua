return {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('spectre').setup {
      color_devicons = true,
      highlight = { ui = 'String', search = 'DiffChange', replace = 'DiffDelete' },
      mapping = {
        ['toggle_line'] = { map = 'dd', cmd = "<cmd>lua require('spectre').toggle_line()<CR>" },
        ['enter_file'] = { map = '<cr>', cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>" },
        ['send_to_qf'] = { map = '<leader>q', cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>" },
        ['replace_cmd'] = { map = '<leader>c', cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>" },
        ['run_current_replace'] = { map = '<leader>rc', cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>" },
        ['run_replace'] = { map = '<leader>R', cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>" },
        ['change_view_mode'] = { map = '<leader>v', cmd = "<cmd>lua require('spectre').change_view()<CR>" },
      },
      find_engine = {
        ['rg'] = {
          cmd = 'rg',
          args = { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column' },
          options = {
            ['ignore-case'] = { value = '--ignore-case', icon = '[I]', desc = 'ignore case' },
            ['hidden'] = { value = '--hidden', desc = 'hidden file', icon = '[H]' },
          },
        },
      },
      replace_engine = {
        ['sed'] = { cmd = 'sed', args = nil, options = { ['ignore-case'] = { value = '--ignore-case', icon = '[I]', desc = 'ignore case' } } },
      },
      default = { find = { cmd = 'rg', options = { 'ignore-case' } }, replace = { cmd = 'sed' } },
    }

    vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', { desc = 'Toggle Spectre' })
    vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', { desc = 'Search current word' })
    vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = 'Search current word' })
  end,
}
