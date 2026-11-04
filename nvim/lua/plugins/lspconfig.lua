return {
  -- Lua LSP awareness of the Neovim runtime and plugins (replaces neodev)
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
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason-org/mason.nvim',
      'hrsh7th/cmp-nvim-lsp',
      { 'antosha417/nvim-lsp-file-operations', config = true },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
        callback = function(ev)
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(
              mode,
              lhs,
              rhs,
              { buffer = ev.buf, silent = true, desc = desc }
            )
          end

          map('n', 'gR', '<cmd>Telescope lsp_references<CR>', 'LSP references')
          map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
          map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
          map(
            'n',
            'gi',
            '<cmd>Telescope lsp_implementations<CR>',
            'LSP implementations'
          )
          map(
            'n',
            'gt',
            '<cmd>Telescope lsp_type_definitions<CR>',
            'LSP type definitions'
          )
          map(
            { 'n', 'v' },
            '<leader>ca',
            vim.lsp.buf.code_action,
            'Code actions'
          )
          map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
          map(
            'n',
            '<leader>D',
            '<cmd>Telescope diagnostics bufnr=0<CR>',
            'Buffer diagnostics'
          )
          map('n', '<leader>d', vim.diagnostic.open_float, 'Line diagnostics')
          map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
          map('n', '<leader>rs', '<cmd>LspRestart<CR>', 'Restart LSP')
          -- [d / ]d for diagnostics are built into Neovim 0.11+
        end,
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config('*', { capabilities = capabilities })

      -- Tailwind and cssls: don't paint colour swatches over the code
      local function disable_document_color(_, bufnr)
        vim.lsp.document_color.enable(false, { bufnr = bufnr })
      end

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = { completion = { callSnippet = 'Replace' } },
        },
      })

      -- Pyright only provides completion/navigation; Ruff does the linting.
      vim.lsp.config('pyright', {
        settings = {
          pyright = { disableOrganizeImports = true },
          python = {
            analysis = {
              ignore = { '*' },
              typeCheckingMode = 'off',
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              autoImportCompletions = true,
            },
          },
        },
      })

      local ts_inlay_hints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = 'literals', -- 'none' | 'literals' | 'all'
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      }
      vim.lsp.config('ts_ls', {
        settings = {
          typescript = { inlayHints = ts_inlay_hints },
          javascript = { inlayHints = ts_inlay_hints },
        },
      })

      vim.lsp.config('tailwindcss', { on_attach = disable_document_color })
      vim.lsp.config('cssls', { on_attach = disable_document_color })

      vim.diagnostic.config {
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = '󰋼 ',
            [vim.diagnostic.severity.HINT] = '󰌵 ',
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
  },
}
