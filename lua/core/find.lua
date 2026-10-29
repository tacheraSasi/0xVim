-- Search helpers that use the explorer's root when the cursor is inside the
-- sidebar, instead of Neovim's cwd (which can differ after `set_root`).
local M = {}

function M.root()
  if vim.bo.filetype == 'neo-tree' then
    local ok, manager = pcall(require, 'neo-tree.sources.manager')
    if ok and manager then
      local state = manager.get_state 'filesystem'
      if state and state.path and vim.fn.isdirectory(state.path) == 1 then
        return state.path
      end
    end
  end
  return nil
end

function M.find_files(opts)
  opts = vim.tbl_extend('force', { cwd = M.root() }, opts or {})
  require('telescope.builtin').find_files(opts)
end

function M.live_grep(opts)
  opts = vim.tbl_extend('force', { cwd = M.root() }, opts or {})
  require('telescope.builtin').live_grep(opts)
end

return M
