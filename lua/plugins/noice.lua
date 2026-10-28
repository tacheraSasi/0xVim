return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    notify = { enabled = false },
    lsp = {
      override = { ['vim.lsp.util.convert_input_to_markdown_lines'] = true, ['vim.lsp.util.stylize_markdown'] = true },
      progress = { enabled = false },
      hover = { enabled = true },
      signature = { enabled = true },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = true,
    },
    cmdline = {
      view = 'cmdline',
    },
  },
}
