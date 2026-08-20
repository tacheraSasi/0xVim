local function beast_header()
  return {
    '',
    '             >> B E A S T   M O D E   A C T I V A T E D <<',
    '',
  }
end

local function beast_footer()
  local quotes = {
    { '  Code is poetry. Ship it.', '  — every great dev' },
    { '  Stay hungry. Stay foolish. Ship fast.', '  — Steve Jobs' },
    { '  Talk is cheap. Show me the code.', '  — Linus Torvalds' },
    { '  First, solve the problem. Then write the code.', '  — John Johnson' },
    { '  Simplicity is the soul of efficiency.', '  — Austin Freeman' },
    { '  The best code is no code at all.', '  — Jeff Atwood' },
    { '  Make it work, make it right, make it fast.', '  — Kent Beck' },
    { '  Premature optimization is the root of all evil.', '  — Donald Knuth' },
    { '  Programs must be written for people to read.', '  — Harold Abelson' },
    { '  It works on my machine. Ship it.', '  — every dev ever' },
    { '  Git push --force. What could go wrong?', '  — famous last words' },
    { '  There are only two hard things in CS:', '  cache invalidation and naming things' },
    { '  99 little bugs in the code, patch one down,', '  pass it around, 127 little bugs now' },
    { '  I do not fear computers. I fear lack of them.', '  — Isaac Asimov' },
    { '  A user interface is like a joke.', '  if you have to explain it, it is not that good' },
  }
  math.randomseed(os.time())
  local q = quotes[math.random(#quotes)]
  local stats = vim.fn.wordcount()
  return {
    '',
    q[1],
    q[2],
    '',
    '  0xVim  ·  Neovim ' .. vim.version().major .. '.' .. vim.version().minor .. '+',
    '  ⚡ ' .. #vim.fn.getcompletion('', 'color') .. ' themes  ·  ' .. #vim.fn.getcompletion('', 'command') .. ' commands',
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
      change_to_vcs_root = true,
      config = {
        header = beast_header(),
        footer = beast_footer,
        shortcut = {
          {
            desc = ' Find File',
            icon = ' ',
            group = 'DiagnosticOk',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Recent Files',
            icon = ' ',
            group = 'DiagnosticHint',
            action = 'Telescope oldfiles',
            key = 'r',
          },
          {
            desc = ' Projects',
            icon = ' ',
            group = 'DiagnosticWarn',
            action = 'Telescope projects',
            key = 'p',
          },
          {
            desc = ' Explorer',
            icon = ' ',
            group = 'Label',
            action = 'Neotree toggle filesystem right',
            key = 'e',
          },
          {
            desc = ' Terminal',
            icon = ' ',
            group = 'Number',
            action = 'ToggleTerm',
            key = 't',
          },
          {
            desc = ' Themes',
            icon = ' ',
            group = 'Special',
            action = 'Telescope colorscheme',
            key = 's',
          },
          {
            desc = ' How To Guide',
            icon = ' ',
            group = 'Question',
            action = 'edit ' .. vim.fn.stdpath('config') .. '/HOW_TO.md',
            key = 'h',
          },
          {
            desc = ' Config',
            icon = ' ',
            group = 'Function',
            action = 'Telescope find_files cwd=' .. vim.fn.stdpath('config'),
            key = 'c',
          },
          {
            desc = ' Lazy',
            icon = ' ',
            group = 'Constant',
            action = 'Lazy',
            key = 'l',
          },
          {
            desc = ' Mason',
            icon = ' ',
            group = 'Type',
            action = 'Mason',
            key = 'm',
          },
          {
            desc = ' Quit',
            icon = ' ',
            group = 'DiagnosticError',
            action = 'qa',
            key = 'q',
          },
        },
        project = { enable = true, limit = 6, icon = '  ', label = 'Projects', action = 'Telescope find_files cwd=' },
        mru = { limit = 8, icon = '  ', label = 'Recent Files' },
      },
    }
  end,
}
