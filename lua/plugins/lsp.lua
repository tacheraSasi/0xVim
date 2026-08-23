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

        local function server_supports(method)
          local clients = vim.lsp.get_clients { bufnr = event.buf }
          for _, c in ipairs(clients) do
            if c:supports_method(method, event.buf) then return true end
          end
          return false
        end

        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
        map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gri', function()
          if server_supports(vim.lsp.protocol.Methods.textDocument_implementation) then
            require('telescope.builtin').lsp_implementations()
          else
            vim.notify('Server does not support implementations — showing references instead', vim.log.levels.WARN)
            require('telescope.builtin').lsp_references()
          end
        end, '[G]oto [I]mplementation')
        map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
        map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
        map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- Open the actual source file of a definition (e.g. Go/Zig stdlib).
        -- gd/F12 jump in-place; these open in a split so you keep your spot
        -- and can read the real implementation alongside your code.
        map('gD', function()
          require('telescope.builtin').lsp_definitions { jump_type = 'vsplit' }
        end, '[G]oto [D]efinition in vsplit')
        map('gH', function()
          require('telescope.builtin').lsp_definitions { jump_type = 'split' }
        end, '[G]oto [D]efinition in hsplit')
        map('gI', function()
          if server_supports(vim.lsp.protocol.Methods.textDocument_implementation) then
            require('telescope.builtin').lsp_implementations { jump_type = 'vsplit' }
          else
            vim.notify('Server does not support implementations — showing references instead', vim.log.levels.WARN)
            require('telescope.builtin').lsp_references()
          end
        end, '[G]oto [I]mplementation in vsplit')

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and client.server_capabilities.documentSymbolProvider then
          local ok, navic = pcall(require, 'nvim-navic')
          if ok then navic.attach(client, event.buf) end
        end

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'BufWinEnter' }, {
          group = vim.api.nvim_create_augroup('navic-winbar', { clear = true }),
          callback = function()
            local ok, navic = pcall(require, 'nvim-navic')
            if ok and navic.is_available() then
              vim.wo.winbar = navic.get_location()
            end
          end,
        })

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

    -- mason-lspconfig v2 enables installed servers natively via vim.lsp.enable;
    -- custom settings must be registered through vim.lsp.config to apply.
    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    vim.lsp.config('tailwindcss', {
      filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'javascript', 'typescript', 'vue', 'svelte', 'php', 'blade' },
      settings = {
        tailwindCSS = {
          classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
          includeLanguages = { eelixir = 'html', eruby = 'html' },
          lint = { cssConflict = 'warning', invalidApply = 'error', invalidScreen = 'error', invalidVariant = 'error', invalidConfigPath = 'error', invalidTailwindDirective = 'error', recommendedVariantOrder = 'warning' },
        },
      },
    })

    vim.lsp.config('gopls', {
      settings = {
        gopls = {
          completeUnimported = true, usePlaceholders = true,
          analyses = { unusedparams = true, shadow = true },
          staticcheck = true, gofumpt = true,
        },
      },
    })

    vim.lsp.config('pyright', {
      settings = {
        python = {
          analysis = { autoImportCompletions = true, typeCheckingMode = 'basic', useLibraryCodeForTypes = true },
        },
      },
    })

    vim.lsp.config('clangd', {
      settings = {
        clangd = {
          compilationDatabase = './build',
          fallbackFlags = { '-std=c++17' },
          inlayHints = { enabled = true, parameterNames = true, deducedTypes = true },
        },
      },
    })

    vim.lsp.config('zls', {
      settings = {
        zls = {
          enable_inlay_hints = true,
          inlay_hints_show_builtin = true,
          inlay_hints_exclude_single_argument = false,
          inlay_hints_hide_redundant_param_names = false,
          inlay_hints_hide_redundant_param_names_last_token = false,
        },
      },
    })

    vim.lsp.config('jsonls', {
      settings = {
        json = { schemas = require('schemastore').json.schemas(), validate = { enable = true } },
      },
    })

    vim.lsp.config('yamlls', {
      settings = {
        yaml = {
          schemas = {
            ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
            ['https://json.schemastore.org/github-action.json'] = '/action.{yml,yaml}',
            ['https://json.schemastore.org/docker-compose.json'] = '/*docker-compose*.{yml,yaml}',
            ['https://json.schemastore.org/kustomization.json'] = '/kustomization.{yml,yaml}',
            ['https://json.schemastore.org/prettierrc.json'] = '/.prettierrc.{yml,yaml}',
            ['https://json.schemastore.org/dependabot-v2.json'] = '/.github/dependabot.{yml,yaml}',
          },
        },
      },
    })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = { completion = { callSnippet = 'Replace' } },
      },
    })

    vim.lsp.config('intelephense', {
      settings = {
        intelephense = {
          format = { braces = 'k&r' },
          environment = { includePaths = { 'vendor/**' } },
          files = { maxSize = 5000000 },
          completion = { maxItems = 100, fullyQualifyGlobalConstantsAndFunctions = true },
          diagnostics = { enable = true, run = 'onType' },
        },
      },
    })

    local servers = {
      'ts_ls', 'gopls', 'pyright', 'rust_analyzer', 'clangd', 'zls', 'html',
      'cssls', 'jsonls', 'yamlls', 'lemminx', 'dockerls', 'bashls', 'marksman',
      'lua_ls', 'intelephense', 'volar', 'svelte', 'prismals', 'graphql',
      'docker_compose_language_service',
    }

    -- Map lspconfig server names to Mason package names where they differ.
    local lsp_to_mason = {
      tailwindls = 'tailwindcss-language-server',
      ts_ls = 'typescript-language-server',
      docker_compose_language_service = 'docker-compose-language-service',
      volar = 'vue-language-server',
      lua_ls = 'lua-language-server',
      graphql = 'graphql-language-service-cli',
      prismals = 'prisma-language-server',
      bashls = 'bash-language-server',
      cssls = 'css-lsp',
      dockerls = 'dockerfile-language-server',
      html = 'html-lsp',
      jsonls = 'json-lsp',
      yamlls = 'yaml-language-server',
      svelte = 'svelte-language-server',
    }
    local ensure_installed = {}
    for _, server_name in ipairs(servers) do
      table.insert(ensure_installed, lsp_to_mason[server_name] or server_name)
    end
    vim.list_extend(ensure_installed, {
      'stylua', 'prettier', 'prettierd', 'black', 'isort', 'shfmt', 'gofumpt',
      'goimports', 'golines', 'rustfmt', 'clang-format', 'blade-formatter',
      'eslint_d', 'flake8', 'ruff', 'shellcheck', 'luacheck',
      'php-cs-fixer', 'phpstan', 'phpcs', 'phpcbf',
      'golangci-lint', 'revive', 'staticcheck',
      'markdownlint-cli2', 'jsonlint', 'yamllint',
      'codelldb', 'delve',
      'tailwindcss-language-server',
      'gomodifytags', 'gotests', 'impl', 'iferr',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
      automatic_enable = { exclude = { 'ts_ls', 'rust_analyzer' } },
    }
  end,
},
}
