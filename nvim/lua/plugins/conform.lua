return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'eslint_d' },
        typescript = { 'prettierd', 'eslint_d' },
        javascriptreact = { 'prettierd', 'eslint_d' },
        typescriptreact = { 'prettierd', 'eslint_d' },
        css = { 'prettierd' },
        html = { 'prettierd' },
        json = { 'prettierd' },
        yaml = { 'prettierd' },
        markdown = { 'prettierd' },
        graphql = { 'prettierd' },
        python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
      },

      format_on_save = {
        pattern = '.lua,*.graphql,*.css,*.html,*.json,*.yaml,*.md,*.gql,*.rs, *.py, *.ts, *.tsx, *.js, *.jsx',
        timeout_ms = 1000,
        async = false,
        lsp_fallback = true,
      },
    }
  end,
}
