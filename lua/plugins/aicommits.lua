-- aicommits.nvim — AI-generated conventional commit messages.
-- Pointed at OpenCode Go (https://opencode.ai/zen/go/v1) — an
-- OpenAI-compatible endpoint — so it works with the OpenCode subscription.
--
-- API key: the plugin reads OPENCODE_API_KEY (or AICOMMITS_NVIM_OPENAI_API_KEY).
-- Add `export OPENCODE_API_KEY=...` to your shell profile. Never commit the
-- key to this repo.
-- Note: OpenCode Go only accepts n = 1, so generate is forced to 1.
return {
  '404pilo/aicommits.nvim',
  cmd = { 'AICommit', 'AICommitHealth', 'AICommitDebug' },
  keys = {
    { '<Space>ga', '<cmd>AICommit<CR>', desc = 'AI commit message' },
  },
  config = function()
    require('aicommits').setup {
      active_provider = 'openai',
      providers = {
        openai = {
          enabled = true,
          endpoint = 'https://opencode.ai/zen/go/v1/chat/completions',
          api_key = vim.env.OPENCODE_API_KEY or vim.env.AICOMMITS_NVIM_OPENAI_API_KEY,
          model = 'glm-5.3', -- deepseek-v4-flash over-reasons and truncates; glm-5.3 is reliable
          max_length = 72,
          generate = 1, -- OpenCode Go only supports n = 1 (single option)
          max_tokens = 200,
        },
      },
      ui = {
        use_custom_picker = true,
        picker = { width = 0.4, height = 0.3, border = 'rounded' },
      },
      integrations = {
        neogit = {
          enabled = true,
          mappings = { enabled = true, key = 'C' },
        },
      },
    }
  end,
}