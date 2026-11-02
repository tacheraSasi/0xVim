-- Loading indicator for octo.nvim.
--
-- Octo talks to GitHub by shelling out to `gh` asynchronously, so until the
-- response arrives its buffers are just empty and a slow query looks like the
-- command did nothing. Wrap the API entry points and report outstanding
-- requests through fidget (the same corner window LSP progress already uses).
--
-- Short requests are common, so the spinner only appears once a request has
-- been in flight for DELAY ms — otherwise every action would flash.
local M = {}

local DELAY = 250

local active = 0
local handle = nil
local timer = nil

local function stop_timer()
  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end
end

---Start tracking one in-flight request.
---@return fun() finish called exactly once when the request completes
local function start()
  active = active + 1

  if active == 1 then
    timer = vim.uv.new_timer()
    timer:start(
      DELAY,
      0,
      vim.schedule_wrap(function()
        stop_timer()
        if active == 0 then
          return
        end

        local ok, progress = pcall(require, 'fidget.progress.handle')
        if not ok then
          return
        end

        local created, new_handle = pcall(progress.create, {
          lsp_client = { name = 'octo' },
          title = 'GitHub',
          message = 'Fetching from GitHub…',
        })
        if created then
          handle = new_handle
        end
      end)
    )
  end

  local finished = false
  return function()
    if finished then
      return
    end
    finished = true
    active = math.max(active - 1, 0)

    if active > 0 then
      return
    end

    stop_timer()
    if handle then
      pcall(handle.finish, handle)
      handle = nil
    end
  end
end

---Wrap one `octo.gh.api` function so async calls show progress.
---@param name string
function M.wrap(name)
  local api = require('octo.gh').api
  local original = api[name]
  if type(original) ~= 'function' then
    return
  end

  api[name] = function(opts)
    opts = opts or {}
    local run_opts = opts.opts or {}
    local callback = run_opts.cb

    -- Sync calls block the editor, so a spinner would never get painted.
    if not callback then
      return original(opts)
    end

    local finish = start()
    run_opts.cb = function(...)
      finish()
      return callback(...)
    end
    opts.opts = run_opts

    local ok, err = pcall(original, opts)
    if not ok then
      finish()
      error(err)
    end
  end
end

function M.setup()
  if M._wrapped then
    return
  end
  M._wrapped = true

  for _, name in ipairs { 'graphql', 'get', 'post', 'patch', 'delete', 'put' } do
    M.wrap(name)
  end
end

return M
