return {
  'adalessa/laravel.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-neotest/nvim-nio',
  },
  ft = { 'php', 'blade' },
  event = { 'BufEnter composer.json' },
  keys = {
    { '<leader>ll', function() Laravel.pickers.laravel() end, desc = 'Laravel: Picker' },
    { '<leader>la', function() Laravel.pickers.artisan() end, desc = 'Laravel: Artisan' },
    { '<leader>lr', function() Laravel.pickers.routes() end, desc = 'Laravel: Routes' },
    { '<leader>lm', function() Laravel.pickers.make() end, desc = 'Laravel: Make' },
    { '<leader>lc', function() Laravel.pickers.commands() end, desc = 'Laravel: Commands' },
    { '<leader>lo', function() Laravel.pickers.resources() end, desc = 'Laravel: Resources' },
    { '<leader>lt', function() Laravel.commands.run('actions') end, desc = 'Laravel: Code Actions' },
    { '<leader>lu', function() Laravel.commands.run('hub') end, desc = 'Laravel: Artisan Hub' },
    { '<leader>lp', function() Laravel.commands.run('command_center') end, desc = 'Laravel: Command Center' },
    { '<leader>lh', function() Laravel.run('artisan docs') end, desc = 'Laravel: Documentation' },
    {
      'gf',
      function()
        if Laravel.app('gf').cursorOnResource() then
          return '<cmd>lua Laravel.commands.run("gf")<cr>'
        end
        return 'gf'
      end,
      expr = true,
      noremap = true,
      desc = 'Laravel: Go to resource',
    },
  },
  opts = {
    features = { pickers = { provider = 'telescope' } },
  },
  config = function(_, opts)
    require('laravel').setup(opts)
    local ok, blink = pcall(require, 'blink.cmp')
    if ok then
      blink.add_filetype_source('php', 'laravel')
      blink.add_filetype_source('blade', 'laravel')
      blink.add_filetype_source('tinker', 'laravel')
    end
  end,
}