return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    'saghen/blink.cmp',
    'b0o/schemastore.nvim',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
        map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
        map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
        map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and client.server_capabilities.documentSymbolProvider then
          local ok, navic = pcall(require, 'nvim-navic')
          if ok then navic.attach(client, event.buf) end
        end

        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local hl_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf, group = hl_augroup, callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf, group = hl_augroup, callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(e)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = e.buf }
            end,
          })
        end

        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>ti', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = { source = 'if_many', spacing = 2 },
    }

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local servers = {
      ts_ls = {
        settings = {
          typescript = {
            suggest = { completeFunctionCalls = true },
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
            suggest = { completeFunctionCalls = true },
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
      gopls = {
        settings = {
          gopls = {
            completeUnimported = true, usePlaceholders = true,
            analyses = { unusedparams = true, shadow = true },
            staticcheck = true, gofumpt = true,
          },
        },
      },
      pyright = {
        settings = {
          python = {
            analysis = { autoImportCompletions = true, typeCheckingMode = "basic", useLibraryCodeForTypes = true },
          },
        },
      },
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
            imports = { granularity = { group = "module" }, prefix = "self" },
            cargo = { buildScripts = { enable = true } },
            procMacro = { enable = true },
          },
        },
      },
      clangd = {
        settings = { clangd = { compilationDatabase = "./build", fallbackFlags = { "-std=c++17" } } },
      },
      zls = {
        settings = {
          zls = {
            enable_inlay_hints = true,
            inlay_hints_show_builtin = true,
            inlay_hints_exclude_single_argument = false,
            inlay_hints_hide_redundant_param_names = false,
            inlay_hints_hide_redundant_param_names_last_token = false,
          },
        },
      },
      html = {},
      cssls = {},
      jsonls = {
        settings = {
          json = { schemas = require('schemastore').json.schemas(), validate = { enable = true } },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://json.schemastore.org/github-action.json"] = "/action.{yml,yaml}",
              ["https://json.schemastore.org/docker-compose.json"] = "/*docker-compose*.{yml,yaml}",
              ["https://json.schemastore.org/kustomization.json"] = "/kustomization.{yml,yaml}",
              ["https://json.schemastore.org/prettierrc.json"] = "/.prettierrc.{yml,yaml}",
              ["https://json.schemastore.org/dependabot-v2.json"] = "/.github/dependabot.{yml,yaml}",
            },
          },
        },
      },
      lemminx = {},
      dockerls = {},
      bashls = {},
      marksman = {},
      lua_ls = {
        settings = {
          Lua = { completion = { callSnippet = 'Replace' } },
        },
      },
    }

    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, {
      'stylua', 'prettier', 'black', 'shfmt', 'gofumpt', 'rustfmt',
      'eslint_d', 'flake8', 'shellcheck', 'luacheck',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
},
}
