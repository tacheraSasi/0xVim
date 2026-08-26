return {
  'ahmedkhalf/project.nvim',
  config = function()
    require('project_nvim').setup {
      -- Don't silently re-cd Neovim when opening files: a stray LSP root or
      -- subdirectory used to drag the whole session (explorer + terminals) there.
      manual_mode = true,
      detection_methods = { 'pattern' },
      patterns = { '.git', 'Makefile', 'package.json', 'Cargo.toml', 'go.mod', 'build.zig' },
      silent_chdir = true,
      scope_chdir = 'global',
    }
    pcall(require('telescope').load_extension, 'projects')
    vim.keymap.set('n', '<leader>pp', function()
      require('telescope').extensions.projects.projects {}
    end, { desc = 'Project switcher' })
  end,
}
