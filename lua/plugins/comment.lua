return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  opts = {
    toggler = { line = 'gcc', block = 'gbc' },
    opleader = { line = 'gc', block = 'gb' },
    mappings = { basic = true, extra = false },
    -- Comment the right way inside JSX/Vue/Svelte/etc.: ts-context-commentstring
    -- resolves the commentstring from treesitter's language injection context.
    -- Required lazily here (not at setup) so the hook only loads the plugin
    -- on the first actual comment.
    pre_hook = function(ctx)
      return require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()(ctx)
    end,
  },
}
