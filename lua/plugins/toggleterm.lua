return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      size = function(term)
        if term.direction == 'horizontal' then return 15
        elseif term.direction == 'vertical' then return vim.o.columns * 0.4 end
      end,
      open_mapping = [[<C-`>]],
      hide_numbers = true, shade_terminals = true, shading_factor = 2,
      start_in_insert = true, persist_size = true, direction = 'float',
      close_on_exit = true, shell = vim.o.shell, auto_scroll = true,
      float_opts = {
        border = 'curved',
        width = function() return math.ceil(vim.o.columns * 0.8) end,
        height = function() return math.ceil(vim.o.lines * 0.8) end,
        winblend = 0,
      },
    }

    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = 'Terminal: left window' })
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = 'Terminal: lower window' })
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = 'Terminal: upper window' })
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = 'Terminal: right window' })
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], { desc = 'Terminal: window prefix' })

    vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<CR>', { desc = 'Toggle floating terminal' })
    vim.keymap.set('n', '<leader>tV', ':ToggleTerm direction=vertical<CR>', { desc = 'Toggle vertical terminal' })
    vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal<CR>', { desc = 'Toggle horizontal terminal' })
  end,
}
