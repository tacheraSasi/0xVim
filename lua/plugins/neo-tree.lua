return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  keys = {
    {
      '<C-b>',
      function()
        local manager = require 'neo-tree.sources.manager'
        local state = manager.get_state 'filesystem'
        local visible = state and state.winid and vim.api.nvim_win_is_valid(state.winid)
        if visible then
          require('neo-tree.command').execute { action = 'close', source = 'filesystem' }
          local target = _G.__nvim_last_editor_win and _G.__nvim_last_editor_win()
          if target and vim.api.nvim_win_is_valid(target) then
            vim.api.nvim_set_current_win(target)
          end
        else
          require('neo-tree.command').execute { action = 'focus', source = 'filesystem', toggle = false }
        end
      end,
      desc = 'Toggle file explorer',
      silent = true,
    },
    { '<leader>e', '<cmd>Neotree toggle filesystem right<CR>', desc = 'Toggle file explorer', silent = true },
    { '<C-S-e>', '<cmd>Neotree focus filesystem right<CR>', desc = 'Focus file explorer', silent = true },
  },
  opts = {
    close_if_last_window = false,
    popup_border_style = 'rounded',
    enable_git_status = true,
    enable_diagnostics = true,
    open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'fidget' },
    default_component_configs = {
      indent = { indent_size = 2, padding = 1, with_markers = true, indent_marker = '│', last_indent_marker = '└' },
      icon = { folder_closed = '', folder_open = '', folder_empty = 'ﰊ', default = '*' },
      modified = { symbol = '[+]' },
      git_status = {
        symbols = {
          added = '', modified = '', deleted = '✖', renamed = '',
          untracked = '', ignored = '', unstaged = '', staged = '', conflict = '',
        },
      },
    },
    window = {
      position = 'right',
      width = 40,
      auto_expand_width = false,
      mapping_options = { noremap = true, nowait = true },
      mappings = {
        ['<space>'] = { 'toggle_node', nowait = false },
        ['<2-LeftMouse>'] = 'open',
        ['<cr>'] = 'open',
        ['<esc>'] = 'cancel',
        ['P'] = { 'toggle_preview', config = { use_float = true } },
        ['l'] = 'open',
        ['h'] = 'close_node',
        ['S'] = 'open_split',
        ['s'] = 'open_vsplit',
        ['t'] = 'open_tabnew',
        ['C'] = 'close_node',
        ['z'] = 'close_all_nodes',
        ['a'] = { 'add', config = { show_path = 'none' } },
        ['A'] = 'add_directory',
        ['d'] = 'delete',
        ['r'] = 'rename',
        ['y'] = 'copy_to_clipboard',
        ['x'] = 'open',
        ['p'] = 'paste_from_clipboard',
        ['c'] = 'copy',
        ['m'] = 'move',
        ['q'] = 'close_window',
        ['R'] = 'refresh',
        ['?'] = 'show_help',
        ['<'] = 'prev_source',
        ['>'] = 'next_source',
      },
    },
    filesystem = {
      -- Keep Neovim's cwd stable: navigating/re-rooting the tree must not
      -- drag the session (terminals, pickers) into subdirectories.
      bind_to_cwd = false,
      filtered_items = {
        visible = false, hide_dotfiles = false, hide_gitignored = false,
        hide_by_name = { 'node_modules' },
        never_show = { '.DS_Store', 'thumbs.db' },
      },
      follow_current_file = { enabled = true, leave_dirs_open = true },
      hijack_netrw_behavior = 'open_default',
      window = {
        mappings = {
          ['<bs>'] = 'navigate_up',
          ['-'] = 'navigate_up',
          ['.'] = 'set_root',
          ['H'] = 'toggle_hidden',
          ['/'] = 'fuzzy_finder',
          ['f'] = 'filter_on_submit',
          ['<c-x>'] = 'clear_filter',
          ['[g'] = 'prev_git_modified',
          [']g'] = 'next_git_modified',
        },
      },
    },
    buffers = {
      follow_current_file = { enabled = true, leave_dirs_open = false },
      window = { mappings = { ['bd'] = 'buffer_delete', ['<bs>'] = 'navigate_up', ['.'] = 'set_root' } },
    },
  },
}
