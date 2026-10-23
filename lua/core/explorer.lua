-- Shared filesystem-explorer toggle so <C-b> / <D-b> / <leader>e all behave
-- the same: open focuses the tree, close returns focus to the last editor
-- window. Uses the actual window buffer's filetype instead of Neo-tree's
-- cached state.winid, which goes stale when the window is closed from inside
-- the tree (q) or reused by another buffer — the source of the
-- "sometimes doesn't open / sometimes doesn't close" bugs.
local M = {}

local function filesystem_winid()
  local ok, manager = pcall(require, 'neo-tree.sources.manager')
  if not ok or not manager then
    return nil
  end
  local state = manager.get_state 'filesystem'
  local winid = state and state.winid
  if not winid or not vim.api.nvim_win_is_valid(winid) then
    return nil
  end
  -- The window exists, but only counts as the sidebar if it is actually
  -- showing the neo-tree buffer (state.winid can point at a reused window).
  if vim.bo[vim.api.nvim_win_get_buf(winid)].filetype ~= 'neo-tree' then
    return nil
  end
  return winid
end

function M.is_open()
  return filesystem_winid() ~= nil
end

function M.close()
  local winid = filesystem_winid()
  if not winid then
    return
  end
  require('neo-tree.command').execute { action = 'close', source = 'filesystem' }
  local target = _G.__nvim_last_editor_win and _G.__nvim_last_editor_win()
  if target and vim.api.nvim_win_is_valid(target) and target ~= winid then
    vim.api.nvim_set_current_win(target)
  end
end

function M.focus()
  if filesystem_winid() then
    vim.api.nvim_set_current_win(filesystem_winid())
    return
  end
  require('neo-tree.command').execute {
    action = 'focus',
    source = 'filesystem',
    position = 'right',
    toggle = false,
  }
end

function M.toggle()
  if filesystem_winid() then
    M.close()
  else
    M.focus()
  end
end

-- Editor-only window (used by Ctrl+1 style "Focus Editor" mappings)
function M.focus_editor()
  local target = _G.__nvim_last_editor_win and _G.__nvim_last_editor_win()
  if target and vim.api.nvim_win_is_valid(target) then
    vim.api.nvim_set_current_win(target)
    return
  end
  -- Fallback: first non-explorer/non-float window.
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.bo[buf].filetype
    local bt = vim.bo[buf].buftype
    if ft ~= 'neo-tree' and ft ~= 'toggleterm' and bt ~= 'nofile' and bt ~= 'terminal' then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
end

return M
