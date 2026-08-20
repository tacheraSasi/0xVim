-- codediff.nvim — VSCode-style git diff (side-by-side or inline) with a
-- Source-Control-style changes sidebar listing modified files.
-- Same diff engine as VSCode (character-level highlighting via C library).
return {
  'esmuellert/codediff.nvim',
  cmd = { 'CodeDiff' },
  keys = {
    -- VSCode-style git changes sidebar
    { '<D-M-b>', '<cmd>CodeDiff<CR>', desc = 'Git changes sidebar (CodeDiff)' },
    { '<Space>gd', '<cmd>CodeDiff<CR>', desc = 'Git changes (CodeDiff)' },
    { '<Space>gD', '<cmd>CodeDiff history<CR>', desc = 'Git history (CodeDiff)' },
    { '<Space>gf', '<cmd>CodeDiff file % HEAD<CR>', desc = 'Diff current file vs HEAD' },
  },
  opts = {
    diff = {
      layout = 'side-by-side', -- 'side-by-side' or 'inline' (toggle with t in the view)
      original_position = 'left',
      filler_text = '╱',
      disable_inlay_hints = true,
      jump_to_first_change = true,
      gutter_signs = {
        insert_text = '＋',
        delete_text = '－',
        changed_priority = 100,
      },
    },
    explorer = {
      position = 'left', -- supported values: 'left' or 'bottom' (no right)
      width = 40,
      hidden = false,
      view_mode = 'list', -- VSCode-style flat list (i toggles to tree)
      focus_on_select = false, -- stay in the list while browsing, like VSCode
      auto_refresh = true,
      line_stats = {
        enabled = true, -- VSCode-style "+12 -4" counts
        count_untracked = true,
      },
      visible_groups = { staged = true, unstaged = true, conflicts = true },
    },
    keymaps = {
      view = {
        -- <leader>b and <leader>e are used by the buffer group and neo-tree
        -- in this config; disable codediff's defaults to avoid clashes.
        toggle_explorer = false,
        focus_explorer = false,
      },
    },
  },
  config = function(_, opts)
    require('codediff').setup(opts)
    -- aicommits integration: <Space>ga works inside the codediff explorer
    -- and history panels too (stage with S/U/- in the panel, then AI-commit).
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'codediff-explorer', 'codediff-history' },
      callback = function()
        vim.keymap.set('n', '<Space>ga', '<cmd>AICommit<CR>', { buffer = true, desc = 'AI commit message' })
      end,
    })
  end,
}
