return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
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
      sh = { 'shfmt' },
      bash = { 'shfmt' },
    },
    format_on_save = function()
      return { timeout_ms = 1000, lsp_format = 'fallback' }
    end,
  },
}
