return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'mason-org/mason.nvim',
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = 'Show LSP references'
        keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts) -- show definition, references

        opts.desc = 'Go to declaration'
        keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = 'Show LSP definitions'
        keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        -- keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts) -- show lsp definitions

        opts.desc = 'Show LSP implementations'
        keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts) -- show lsp implementations

        opts.desc = 'Show LSP type definitions'
        keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts) -- show lsp type definitions

        opts.desc = 'See available code actions'
        keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = 'Smart rename'
        keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = 'Show buffer diagnostics'
        keymap.set(
          'n',
          '<leader>D',
          '<cmd>Telescope diagnostics bufnr=0<CR>',
          opts
        ) -- show  diagnostics for file

        opts.desc = 'Show line diagnostics'
        keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = 'Go to previous diagnostic'
        keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = 'Go to next diagnostic'
        keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = 'Show documentation for what is under cursor'
        keymap.set('n', 'K', vim.lsp.buf.hover, opts)

        keymap.set(
          'n',
          '<leader>rs',
          ':LspRestart<CR>',
          { desc = 'Restart LSP' }
        ) -- mapping to restart lsp if necessary
      end,
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      settings = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { 'vim' },
          },
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    })

    vim.lsp.config('pyright', {
      capabilities = capabilities,
      settings = {
        pyright = {
          -- Using Ruff's import organizer
          disableOrganizeImports = true,
          analysis = {
            diagnosticSeverityOverrides = {
              reportGeneralTypeIssues = 'none',
              reportOptionalMemberAccess = 'none',
              reportOptionalSubscript = 'none',
              reportPrivateImportUsage = 'none',
              reportUnboundVariable = 'none',
              reportOptionalContextManager = 'none',
              reportUnusedVariable = 'none',
            },
          },
        },
        python = {
          analysis = {
            -- Ignore all files for analysis to exclusively use Ruff for linting
            ignore = { '*' },
            autoSearchPaths = true,
            diagnosticMode = 'file',
            useLibraryCodeForTypes = true,
            typeCheckingMode = 'off',
            autoImportCompletions = true,
            diagnosticSeverityOverrides = {
              reportGeneralTypeIssues = 'none',
              reportOptionalMemberAccess = 'none',
              reportOptionalSubscript = 'none',
              reportPrivateImportUsage = 'none',
              reportUnboundVariable = 'none',
              reportOptionalContextManager = 'none',
              reportUnusedVariable = 'none',
            },
          },
        },
      },
    })

    vim.lsp.config('ts_ls', {
      capabilities = capabilities,
      settings = {
        single_file_support = true,
        typescript = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = 'literals', -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
        javascript = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = 'literals', -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    })

    vim.lsp.config('ruff', { capabilities = capabilities })

    vim.diagnostic.config {
      virtual_text = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.INFO] = '󰋼 ',
          [vim.diagnostic.severity.HINT] = '󰌵 ',
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.HINT] = '',
          [vim.diagnostic.severity.INFO] = '',
        },
      },
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = 'minimal',
        border = 'rounded',
        header = '',
        prefix = '',
      },
    }
  end,
}
