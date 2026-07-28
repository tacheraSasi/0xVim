return {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      disable_move = false,
      shortcut_type = 'letter',
      change_to_vcs_root = true,
      config = {
        week_header = { enable = true },
        shortcut = {
          { desc = ' Files', group = 'Label', action = 'Telescope find_files', key = 'f' },
          { desc = ' Recent', group = 'Label', action = 'Telescope oldfiles', key = 'r' },
          { desc = ' Config', group = 'Label', action = 'Telescope find_files cwd=' .. vim.fn.stdpath('config'), key = 'c' },
          { desc = ' Lazy', group = 'Label', action = 'Lazy', key = 'l' },
          { desc = ' Quit', group = 'Label', action = 'qa', key = 'q' },
        },
        project = { enable = true, limit = 8 },
        mru = { limit = 10, cwd_only = false },
        header = vim.g.have_nerd_font and {
          '                                                 ',
          '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
          '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
          '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
          '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
          '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
          '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
          '                                                 ',
        } or {},
        footer = { 'neovim 0.10+', 'crafted with  by anomalyco' },
      },
    }
  end,
}
