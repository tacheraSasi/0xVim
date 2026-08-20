return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter',
  config = function()
    local function smart_close(bufnum)
      bufnum = bufnum or vim.api.nvim_get_current_buf()
      local real_buffers = 0
      for _, b in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buftype == '' and vim.bo[b].filetype ~= '' then
          real_buffers = real_buffers + 1
        end
      end
      if real_buffers <= 1 then
        vim.cmd('bd ' .. bufnum)
        local ok = pcall(vim.cmd, 'Dashboard')
        if not ok then vim.cmd('enew') end
      else
        local prev_buf = vim.fn.bufnr('#')
        if prev_buf > 0 and vim.api.nvim_buf_is_loaded(prev_buf) and prev_buf ~= bufnum then
          vim.cmd('buffer ' .. prev_buf)
          vim.cmd('bd ' .. bufnum)
        else
          vim.cmd('bd ' .. bufnum)
        end
      end
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
        offsets = { { filetype = 'neo-tree', text = 'Explorer', text_align = 'left' } },
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
