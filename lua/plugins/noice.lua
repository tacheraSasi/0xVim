return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
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
    views = {
      cmdline_popup = { position = { row = '50%', col = '50%' }, size = { width = 60, height = 'auto' }, border = { style = 'rounded' } },
    },
  },
}
