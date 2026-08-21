return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter',
  opts = {
    ensure_installed = { 'bash', 'c', 'cpp', 'css', 'diff', 'html', 'json', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'go', 'rust', 'python', 'typescript', 'tsx', 'javascript', 'php', 'blade', 'vue', 'yaml', 'zig' },
    auto_install = true,
    highlight = { enable = true, additional_vim_regex_highlighting = { 'ruby' } },
    indent = { enable = true, disable = { 'ruby' } },
  },
}
