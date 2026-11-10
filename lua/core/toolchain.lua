-- Toolchain detection helpers.
--
-- On macOS, `/usr/bin/make`, `/usr/bin/cc` and `/usr/bin/clang` exist as stubs
-- even when the Xcode Command Line Tools are *not* installed. `executable()`
-- reports them as available, but running one pops the "Install Command Line
-- Developer Tools" dialog. Build steps should be skipped in that case instead
-- of failing (or interrupting the user with an installer prompt).
--
-- This matters on fresh machines and on setups that use a non-Apple compiler
-- (for example Zig's `zig cc`) but do not have GNU make.

local M = {}

local function is_apple_stub(exe)
  return vim.fn.has 'macunix' == 1 and vim.startswith(exe, '/usr/bin/')
end

-- True when the command is a real, runnable toolchain binary.
function M.has_command(cmd)
  local exe = vim.fn.exepath(cmd)
  if exe == '' then
    return false
  end
  if is_apple_stub(exe) then
    -- `/usr/bin/*` are shims unless the Command Line Tools are installed.
    vim.fn.system { 'xcode-select', '-p' }
    return vim.v.shell_error == 0
  end
  return true
end

function M.has_make()
  return M.has_command 'make'
end

return M
