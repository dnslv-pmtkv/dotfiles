return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  dependencies = {
    'axelvc/template-string.nvim',
  },

  branch = 'main',
  build = ':TSUpdate',
  config = function()
    local treesitter = require 'nvim-treesitter'

    treesitter.setup {
      install_dir = vim.fn.stdpath 'data' .. '/site',

      auto_install = true,
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
    }

    treesitter.install { 'javascript', 'typescript', 'tsx', 'python', 'lua' }
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'python', 'typescript', 'typescriptreact', 'lua' },
      callback = function()
        vim.treesitter.start()
      end,
    })

    require('template-string').setup {}
  end,
}
