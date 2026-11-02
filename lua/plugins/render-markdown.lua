-- Rendered markdown: headings, code blocks, tables, bullets and links are
-- drawn in-buffer instead of showing raw syntax.
--
-- Also applies to octo.nvim's PR/issue buffers: they are filetype `octo` but
-- their contents are markdown, and `octo`'s own FAQ recommends registering
-- the markdown parser for that filetype.
return {
  'MeanderingProgrammer/render-markdown.nvim',
  -- Loaded eagerly: with `ft` lazy-loading, lazy.nvim loads the plugin while
  -- the FileType event is already firing, so the plugin never sees it and
  -- never attaches to that first buffer (octo always sets the filetype itself).
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = function()
    vim.treesitter.language.register('markdown', 'octo')

    -- Octo only sets the filetype; nothing starts a treesitter highlighter for
    -- it. Do that here so markdown (and code fences inside it) gets syntax
    -- highlighting even if render-markdown is not loaded yet.
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'octo',
      callback = function(event)
        if vim.treesitter.highlighter.active[event.buf] then
          return
        end
        pcall(vim.treesitter.start, event.buf, 'markdown')
      end,
    })
  end,
  opts = {
    file_types = { 'markdown', 'octo' },
    -- Octo draws its own signs in the gutter (comment blocks, review
    -- threads); stay out of its way.
    heading = { sign = false },
    code = { sign = false, border = 'thin' },
    paragraph = { enabled = false },
    -- No latex converters are installed, so rendering would just fail.
    latex = { enabled = false },
  },
}
