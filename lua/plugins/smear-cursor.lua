return {
  'sphamba/smear-cursor.nvim',
  opts = {
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    smear_insert_mode = true,
  },
  config = function(_, opts)
    require('smear_cursor').setup(opts)

    local max_smear_lines = 10000
    local enabled = nil
    local function set_enabled(v)
      if v ~= enabled then
        enabled = v
        require('smear_cursor').enabled = v
      end
    end

    local function update_smear()
      if vim.g.neovide then
        set_enabled(false)
        return
      end
      local count = vim.api.nvim_buf_line_count(vim.api.nvim_get_current_buf())
      set_enabled(count <= max_smear_lines)
    end

    vim.api.nvim_create_autocmd({ 'VimEnter', 'BufEnter', 'BufReadPost' }, { callback = update_smear })
    update_smear()
  end,
}