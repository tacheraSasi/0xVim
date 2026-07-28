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
        local ok = pcall(function()
          local state = require('neo-tree.sources.manager').get_state('filesystem')
          if state and state.winid and vim.api.nvim_win_is_valid(state.winid) then
            if vim.api.nvim_get_current_win() == state.winid then
              vim.cmd('Neotree close')
              return
            end
            vim.cmd('Neotree focus')
            return
          end
          vim.cmd('Neotree show')
        end)
        if not ok then
          vim.cmd('Neotree toggle')
        end
      end,
      desc = 'Toggle file explorer',
      silent = true,
    },
    { '<leader>e', ':Neotree toggle<CR>', desc = 'Toggle file explorer', silent = true },
    { '<C-S-e>', ':Neotree focus<CR>', desc = 'Focus file explorer', silent = true },
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = 'rounded',
    enable_git_status = true,
    enable_diagnostics = true,
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
      position = 'left',
      width = 40,
      mappings = {
        ['<space>'] = { 'toggle_node', nowait = false },
        ['<2-LeftMouse>'] = 'open',
        ['<cr>'] = 'open',
        ['<esc>'] = 'close_window',
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
        ['x'] = 'cut_to_clipboard',
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
      filtered_items = {
        visible = false, hide_dotfiles = true, hide_gitignored = true,
        hide_by_name = { 'node_modules' },
        never_show = { '.DS_Store', 'thumbs.db' },
      },
      follow_current_file = { enabled = true, leave_dirs_open = true },
      hijack_netrw_behavior = 'open_default',
      window = {
        mappings = {
          ['<bs>'] = 'navigate_up',
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
