return {
  'rcarriga/nvim-notify',
  opts = {
    background_colour = '#000000',
    fps = 30,
    icons = { DEBUG = '', ERROR = '', INFO = '', TRACE = '✎', WARN = '' },
    level = 2,
    minimum_width = 50,
    render = 'default',
    stages = 'fade_in_slide_out',
    timeout = 5000,
    top_down = true,
  },
  config = function(_, opts)
    require('notify').setup(opts)
    vim.notify = require('notify')
  end,
}
