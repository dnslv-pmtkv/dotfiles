return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'neovim/nvim-lspconfig',
  },
  config = function()
    require('mason-tool-installer').setup {
      ensure_installed = {

        'ruff',

        -- LSP
        'pyright',
        'ts_ls',
        'lua-language-server',
        -- 'ruff-lsp',

        -- Linters
        'eslint',
        'eslint_d',
        'flake8',

        -- Formatters
        'stylua',
        'prettierd',
        'isort',
        'black',
      },
    }
  end,
}
