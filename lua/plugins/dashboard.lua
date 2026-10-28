-- Dashboard: "0XVIM" in the ANSI Shadow style, a random dev quote, and
-- quick shortcuts into the things I actually use.
local function header()
  local art = {
    ' ██████╗  ██╗  ██╗ ██╗   ██╗ ██╗ ███╗   ███╗',
    '██╔═████╗ ╚██╗██╔╝ ██║   ██║ ██║ ████╗ ████║',
    '██║██╔██║  ╚███╔╝  ██║   ██║ ██║ ██╔████╔██║',
    '████╔╝██║  ██╔██╗  ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
    '╚██████╔╝ ██╔╝╚██╗  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
    ' ╚═════╝  ╚═╝  ╚═╝   ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
  }

  local out = { '' }
  vim.list_extend(out, art)
  out[#out + 1] = ''
  out[#out + 1] = string.format('0xVim  ·  Neovim %d.%d', vim.version().major, vim.version().minor)
  out[#out + 1] = ''
  return out
end

local function footer()
  local quotes = {
    { 'Code is poetry. Ship it.', 'every great dev' },
    { 'Stay hungry. Stay foolish. Ship fast.', 'Steve Jobs' },
    { 'Talk is cheap. Show me the code.', 'Linus Torvalds' },
    { 'First, solve the problem. Then write the code.', 'John Johnson' },
    { 'Simplicity is the soul of efficiency.', 'Austin Freeman' },
    { 'The best code is no code at all.', 'Jeff Atwood' },
    { 'Make it work, make it right, make it fast.', 'Kent Beck' },
    { 'Premature optimization is the root of all evil.', 'Donald Knuth' },
    { 'Programs must be written for people to read.', 'Harold Abelson' },
    { 'It works on my machine. Ship it.', 'every dev ever' },
    { 'Git push --force. What could go wrong?', 'famous last words' },
    { 'There are only two hard things in CS: cache invalidation and naming things.', '' },
    { '99 little bugs in the code, patch one down, pass it around, 127 little bugs now.', '' },
    { 'I do not fear computers. I fear lack of them.', 'Isaac Asimov' },
    { 'A user interface is like a joke: if you have to explain it, it is not that good.', '' },
  }

  local q = quotes[math.random(#quotes)]
  local line = q[1] .. (q[2] ~= '' and ('  — ' .. q[2]) or '')

  return {
    '',
    '  “' .. line .. '”',
    '',
    string.format(
      '  %d themes  ·  %d commands',
      #vim.fn.getcompletion('', 'color'),
      #vim.fn.getcompletion('', 'command')
    ),
  }
end

return {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      disable_move = false,
      shortcut_type = 'letter',
      change_to_vcs_root = false,
      config = {
        header = header(),
        footer = footer,
        shortcut = {
          { desc = ' Find File', group = 'DiagnosticOk', action = 'Telescope find_files', key = 'f' },
          { desc = ' Recent Files', group = 'DiagnosticHint', action = 'Telescope oldfiles', key = 'r' },
          { desc = ' Projects', group = 'DiagnosticWarn', action = "lua require('core.projects').pick()", key = 'p' },
          { desc = ' Explorer', group = 'Label', action = 'Neotree toggle filesystem right', key = 'e' },
          { desc = ' Terminal', group = 'Number', action = 'ToggleTerm', key = 't' },
          { desc = ' Themes', group = 'Special', action = 'Telescope colorscheme', key = 's' },
          { desc = ' How To Guide', group = 'Question', action = 'edit ' .. vim.fn.stdpath('config') .. '/HOW_TO.md', key = 'h' },
          { desc = ' Config', group = 'Function', action = 'Telescope find_files cwd=' .. vim.fn.stdpath('config'), key = 'c' },
          { desc = ' Lazy', group = 'Constant', action = 'Lazy', key = 'l' },
          { desc = ' Mason', group = 'Type', action = 'Mason', key = 'm' },
          { desc = ' Quit', group = 'DiagnosticError', action = 'qa', key = 'q' },
        },
        project = { enable = true, limit = 6, icon = '  ', label = 'Projects', action = 'ProjectOpen ' },
        mru = { limit = 8, icon = '  ', label = 'Recent Files' },
      },
    }
  end,
}
