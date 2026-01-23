return {
  'mason-org/mason-lspconfig.nvim',
  opts = {
    ensure_installed = {
      'eslint',
      'ts_ls',
      'html',
      'cssls',
      'tailwindcss',
      'lua_ls',
      'pyright',
    },
  },
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
  },
}
