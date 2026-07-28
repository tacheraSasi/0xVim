return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = function() return vim.fn.executable 'make' == 1 end },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = {
          "%.git/", "node_modules/", "dist/", "build/", "target/", "vendor/",
          "__pycache__/", "%.pyc$", "%.class$", "%.cache/", "tmp/", "%.DS_Store$",
          "Cargo%.lock$", "package%-lock%.json$", "yarn%.lock$",
        },
      },
      pickers = {
        find_files = {
          hidden = false, follow = false,
          find_command = {
            "rg", "--files", "--hidden",
            "-g", "!.git", "-g", "!node_modules", "-g", "!dist", "-g", "!build",
            "-g", "!target", "-g", "!vendor", "-g", "!__pycache__", "-g", "!*.pyc",
            "-g", "!*.o", "-g", "!*.exe", "-g", "!*.dll", "-g", "!*.so",
            "-g", "!.DS_Store", "-g", "!*.log", "-g", "!coverage", "-g", "!*.min.js",
            "-g", "!package-lock.json", "-g", "!yarn.lock", "-g", "!Cargo.lock",
            "-g", "!tmp", "-g", "!.cache", "-g", "!.vscode", "-g", "!.idea",
          },
        },
      },
      extensions = { ['ui-select'] = {} },
    }
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
    end, { desc = '[/] Fuzzily search in current buffer' })
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
