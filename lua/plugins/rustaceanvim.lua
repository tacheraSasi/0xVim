return {
  'mrcjkb/rustaceanvim',
  version = '^5',
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ['rust-analyzer'] = {
            checkOnSave = { command = 'clippy' },
            imports = { granularity = { group = 'module' }, prefix = 'self' },
            cargo = { buildScripts = { enable = true } },
            procMacro = { enable = true },
          },
        },
      },
    }
  end,
}