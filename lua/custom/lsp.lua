local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Common LSP settings
local common_settings = {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- Language-specific settings
local language_settings = {
  -- TypeScript/JavaScript
  tsserver = {
    settings = {
      typescript = {
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },

  -- Go
  gopls = {
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
        gofumpt = true,
      },
    },
  },

  -- Python
  pyright = {
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true,
          typeCheckingMode = "basic",
          useLibraryCodeForTypes = true,
        },
      },
    },
  },

  -- Rust
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },

  -- Java
  jdtls = {
    settings = {
      java = {
        configuration = {
          updateBuildConfiguration = "automatic",
        },
        completion = {
          favoriteStaticMembers = {
            "org.junit.Assert.*",
            "org.junit.Assume.*",
            "org.junit.jupiter.api.Assertions.*",
            "org.junit.jupiter.api.Assumptions.*",
            "org.junit.jupiter.api.DynamicContainer.*",
            "org.junit.jupiter.api.DynamicTest.*",
          },
          importOrder = {
            "java",
            "javax",
            "org",
            "com",
          },
        },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
      },
    },
  },
}

-- Setup LSP servers
for server, settings in pairs(language_settings) do
  lspconfig[server].setup(vim.tbl_deep_extend('force', common_settings, settings))
end

-- Auto-import on save
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    local clients = vim.lsp.get_active_clients()
    for _, client in ipairs(clients) do
      if client.supports_method('textDocument/codeAction') then
        vim.lsp.buf.code_action({
          apply = true,
          context = {
            only = { 'source.organizeImports' },
          },
        })
      end
    end
  end,
})

-- Keymaps for imports
vim.keymap.set('n', '<leader>i', function()
  vim.lsp.buf.code_action({
    context = {
      only = { 'source.organizeImports' },
    },
  })
end, { desc = 'Organize Imports' })

-- Show hover documentation
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show Documentation' })

-- Show signature help
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show Signature Help' }) 