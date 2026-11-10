-- Raise the open-file limit at startup.
--
-- macOS launchd gives GUI apps (Neovide, Finder) a soft RLIMIT_NOFILE of 256.
-- LSP servers, treesitter, image previews and Shada writes can exhaust that,
-- producing:
--   E886: System error while opening temporary ShaDa file ... too many open files
--
-- The hard limit is usually unlimited, so raise the soft limit to it from
-- inside the process. This works regardless of how Neovim was launched.
local M = {}

function M.raise_nofile()
  local ok, ffi = pcall(require, 'ffi')
  if not ok then
    return
  end

  pcall(ffi.cdef, [[
    typedef unsigned long rlim_t;
    struct rlimit { rlim_t rlim_cur; rlim_t rlim_max; };
    int getrlimit(int resource, struct rlimit *rlim);
    int setrlimit(int resource, const struct rlimit *rlim);
  ]])

  -- RLIMIT_NOFILE is 8 on Darwin and 7 on Linux.
  local resource = vim.fn.has('macunix') == 1 and 8 or 7
  local rlim = ffi.new('struct rlimit')
  if ffi.C.getrlimit(resource, rlim) ~= 0 then
    return
  end
  local cur = tonumber(rlim.rlim_cur) or 0
  local max = tonumber(rlim.rlim_max) or 0
  -- 65536 is plenty for LSPs/treesitter/image previews and avoids handing
  -- tools an "unlimited" value they may mishandle.
  local target = math.min(max, 65536)
  if cur < target then
    rlim.rlim_cur = target
    ffi.C.setrlimit(resource, rlim)
  end
end

return M
