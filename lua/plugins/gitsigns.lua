return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' }, change = { text = '~' }, delete = { text = '_' },
      topdelete = { text = '‾' }, changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', ']c', function()
        if vim.wo.diff then vim.cmd.normal { ']c', bang = true }
        else gitsigns.nav_hunk 'next' end
      end, { desc = 'Next git change' })
      map('n', '[c', function()
        if vim.wo.diff then vim.cmd.normal { '[c', bang = true }
        else gitsigns.nav_hunk 'prev' end
      end, { desc = 'Previous git change' })

      map('v', '<leader>hs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Stage hunk' })
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Reset hunk' })
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Stage buffer' })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
      map('n', '<leader>hb', gitsigns.blame_line, { desc = 'Blame line' })
      map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Diff against index' })
      map('n', '<leader>hD', function()
        gitsigns.diffthis '@'
      end, { desc = 'Diff against last commit' })
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle blame line' })
    end,
  },
}
