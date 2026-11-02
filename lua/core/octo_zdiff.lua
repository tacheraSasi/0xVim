-- Open the current octo PR in zdiff.nvim.
--
-- zdiff diffs `merge-base(base, HEAD)` against the working tree, so the PR
-- branch has to be checked out first: there is no way to hand it a detached
-- head. This checks the PR out (only on a clean tree, and only after asking)
-- and then diffs against the PR's base branch, which yields exactly the
-- changes GitHub shows for the PR.
local M = {}

local function notify(msg, level)
  vim.notify('PR diff: ' .. msg, level or vim.log.levels.INFO)
end

local function git(root, ...)
  local args = { 'git' }
  vim.list_extend(args, { ... })
  return vim.system(args, { cwd = root, text = true }):wait()
end

local function repo_root()
  local res = vim.system({ 'git', 'rev-parse', '--show-toplevel' }, { text = true }):wait()
  if res.code ~= 0 then
    return nil
  end
  return vim.trim(res.stdout)
end

---Resolve the ref to diff from: the PR's base branch, preferring a remote
---tracking ref (and making sure it is up to date). Forks often have the base
---branch on `upstream` rather than `origin`.
---@param root string
---@param base string
---@return string
local function base_ref(root, base)
  for _, remote in ipairs { 'origin', 'upstream' } do
    git(root, 'fetch', '--quiet', remote, base)
    local ref = remote .. '/' .. base
    if git(root, 'rev-parse', '--verify', '--quiet', ref).code == 0 then
      return ref
    end
  end
  return base
end

local function open_zdiff(root, base)
  -- zdiff resolves the repository from the current working directory, and
  -- `repo_root()` already proved the cwd is inside it.
  require('zdiff').open(base_ref(root, base))
end

function M.open()
  local utils = require 'octo.utils'
  local buffer = utils.get_current_buffer()
  if not buffer or not buffer:isPullRequest() then
    notify('open a pull request buffer first', vim.log.levels.WARN)
    return
  end

  local pr = buffer:pullRequest()
  local root = repo_root()
  if not root then
    notify('Neovim is not inside a git repository', vim.log.levels.ERROR)
    return
  end

  local status = git(root, 'status', '--porcelain')
  if status.code ~= 0 then
    notify('git status failed: ' .. vim.trim(status.stderr or ''), vim.log.levels.ERROR)
    return
  end
  if vim.trim(status.stdout or '') ~= '' then
    notify('working tree has uncommitted changes — commit or stash them first', vim.log.levels.WARN)
    return
  end

  local branch = vim.trim(git(root, 'rev-parse', '--abbrev-ref', 'HEAD').stdout or '')
  if branch == pr.headRefName then
    open_zdiff(root, pr.baseRefName)
    return
  end

  local choice = vim.fn.confirm(
    string.format('Checkout PR #%d (%s) and open its diff in zdiff?', pr.number, pr.headRefName),
    '&Yes\n&No',
    1
  )
  if choice ~= 1 then
    return
  end

  -- `gh pr checkout` accepts a number, branch or URL. The URL is unambiguous
  -- even when the buffer is not for the repository Neovim is sitting in.
  local url = pr.url or string.format('https://github.com/%s/pull/%d', buffer.repo, pr.number)
  notify(string.format('checking out PR #%d…', pr.number))

  vim.system({ 'gh', 'pr', 'checkout', url }, { cwd = root, text = true }, function(res)
    vim.schedule(function()
      if res.code ~= 0 then
        notify('gh pr checkout failed: ' .. vim.trim(res.stderr or ''), vim.log.levels.ERROR)
        return
      end
      open_zdiff(root, pr.baseRefName)
    end)
  end)
end

function M.setup()
  if M._setup then
    return
  end
  M._setup = true

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'octo',
    callback = function(event)
      vim.keymap.set('n', '<localleader>pz', M.open, {
        buffer = event.buf,
        desc = 'PR diff in zdiff',
      })
    end,
  })

  vim.api.nvim_create_user_command('OctoZdiff', M.open, {
    desc = 'Check out the current octo PR and open its diff in zdiff',
  })
end

return M
