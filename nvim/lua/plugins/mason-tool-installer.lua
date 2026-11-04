-- Formatters and other non-LSP tools. LSP servers live in mason-lspconfig.lua.
return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  dependencies = { { 'mason-org/mason.nvim', opts = {} } },
  opts = {
    ensure_installed = {
      'stylua',
      'prettierd',
      'eslint_d',
      'ruff',
      'shfmt',
    },
  },
}
