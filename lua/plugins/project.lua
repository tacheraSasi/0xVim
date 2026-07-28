return {
  'ahmedkhalf/project.nvim',
  config = function()
    require('project_nvim').setup {
      manual_mode = false,
      detection_methods = { 'lsp', 'pattern' },
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
