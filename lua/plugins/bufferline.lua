return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter',
  config = function()
    local function smart_close(bufnum)
      require('core.buffers').close(bufnum)
    end

    require('bufferline').setup {
      options = {
        mode = 'buffers',
        numbers = 'none',
        close_command = smart_close,
        right_mouse_command = smart_close,
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level)
          local icon = level:match('error') and ' ' or ' '
          return ' ' .. icon .. count
        end,
        show_buffer_close_icons = true,
        show_tab_indicators = true,
        separator_style = 'thin',
        indicator = { style = 'underline' },
        get_element_icon = function(element)
          return element.icon
        end,
      },
      highlights = {
        indicator_selected = { fg = { attribute = 'fg', highlight = 'Function' } },
      },
    }
    vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
    vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', { desc = 'Next buffer' })
  end,
}
