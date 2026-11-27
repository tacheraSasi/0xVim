-- Shared buffer-closing logic for <leader>bd, Ctrl+Shift+W and bufferline's
-- close button. Previously three copies of this logic drifted apart and all
-- could delete plugin-owned buffers (the neo-tree sidebar) or miscount files
-- whose filetype was not detected yet.
local M = {}

local function is_tree_buf(buf)
  if vim.bo[buf].filetype == 'neo-tree' then
    return true
  end
  return vim.api.nvim_buf_get_name(buf):find('neo%-tree ') ~= nil
end

local function real_buffer_count(exclude)
  local n = 0
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if
      b ~= exclude
      and vim.api.nvim_buf_is_loaded(b)
      and vim.bo[b].buflisted
      and vim.bo[b].buftype == ''
      and (vim.api.nvim_buf_get_name(b) ~= '' or vim.bo[b].modified)
    then
      n = n + 1
    end
  end
  return n
end

-- Closed-buffer history so <C-S-t> ("Reopen Closed Editor") can actually
-- reopen something. :bd deletes the buffer, so the alternate buffer can
-- never point at it. NOTE: :bd unloads + unlists the buffer but the buffer
-- object itself survives (nvim_buf_is_valid stays true), so closure is
-- detected via bufloaded() — and only then recorded. The cursor position
-- must be captured BEFORE the bd (getbufinfo reports lnum=0 once unloaded).
-- Session-local by design (a restored session already restores its files).
local closed_stack = {}
local MAX_CLOSED = 20

local function delete_buf(bufnum)
  local name = vim.api.nvim_buf_get_name(bufnum)
  local lnum = 1
  for _, info in ipairs(vim.fn.getbufinfo(bufnum)) do
    if info.bufnr == bufnum then
      lnum = info.lnum > 0 and info.lnum or 1
    end
  end
  pcall(vim.cmd, 'bd ' .. bufnum)
  if name ~= '' and not vim.api.nvim_buf_is_loaded(bufnum) then
    closed_stack[#closed_stack + 1] = { name = name, lnum = lnum }
    if #closed_stack > MAX_CLOSED then
      table.remove(closed_stack, 1)
    end
  end
end

function M.reopen()
  while #closed_stack > 0 do
    local entry = table.remove(closed_stack)
    if vim.fn.filereadable(entry.name) == 1 then
      vim.cmd('edit ' .. vim.fn.fnameescape(entry.name))
      if entry.lnum > 1 then
        pcall(vim.api.nvim_win_set_cursor, 0, { entry.lnum, 0 })
      end
      return entry.name
    end
  end
  vim.notify('No closed editor to reopen', vim.log.levels.INFO)
end

function M.close(bufnum)
  bufnum = bufnum or vim.api.nvim_get_current_buf()

  -- Never delete the explorer's own buffer; close the window through neo-tree.
  if is_tree_buf(bufnum) then
    pcall(function()
      require('core.explorer').close()
    end)
    return
  end

  local closing_current = bufnum == vim.api.nvim_get_current_buf()

  -- Terminals/help/qf etc. are not real editors; just drop the buffer.
  if vim.bo[bufnum].buftype ~= '' then
    pcall(vim.cmd, 'bd! ' .. bufnum)
    return
  end

  -- Closing a background (bufferline click) must not force-discard edits.
  if not closing_current then
    delete_buf(bufnum)
    return
  end

  if real_buffer_count(bufnum) == 0 then
    delete_buf(bufnum)
    if not pcall(vim.cmd, 'Dashboard') then
      vim.cmd('enew')
    end
    return
  end

  local prev_buf = vim.fn.bufnr('#')
  if
    prev_buf > 0
    and prev_buf ~= bufnum
    and vim.api.nvim_buf_is_loaded(prev_buf)
    and vim.bo[prev_buf].buflisted
    and vim.bo[prev_buf].buftype == ''
  then
    vim.cmd('buffer ' .. prev_buf)
  end
  delete_buf(bufnum)
end

return M
