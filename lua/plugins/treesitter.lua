-- nvim-treesitter's `main` branch dropped `ensure_installed` (and the old
-- highlight/indent modules); Neovim starts the highlighter itself when a parser
-- exists. Keep the list here and install whatever is missing on startup, so a
-- fresh machine gets the same parsers instead of silently having none.
local parsers = {
  'bash', 'c', 'cpp', 'css', 'scss', 'diff', 'html', 'json', 'lua', 'luadoc',
  'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'go', 'rust', 'python',
  'typescript', 'tsx', 'javascript', 'php', 'blade', 'vue', 'yaml', 'zig', 'ruby',
  'toml', 'dockerfile', 'proto',
  -- Snacks.image doc rendering (LaTeX math, Svelte, Typst).
  'latex', 'svelte', 'typst',
}

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter',
  opts = {
    ensure_installed = parsers,
  },
  config = function(_, opts)
    local ts = require 'nvim-treesitter'
    ts.setup(opts)

    local installed = {}
    for _, lang in ipairs(ts.get_installed 'parsers') do
      installed[lang] = true
    end

    local missing = vim.tbl_filter(function(lang)
      return not installed[lang]
    end, opts.ensure_installed)

    if #missing > 0 then
      ts.install(missing)
    end
  end,
}
