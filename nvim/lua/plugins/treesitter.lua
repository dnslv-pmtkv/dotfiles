local parsers = { 'javascript', 'typescript', 'tsx', 'python', 'lua' }

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  dependencies = { 'axelvc/template-string.nvim' },
  config = function()
    local treesitter = require 'nvim-treesitter'

    treesitter.setup { install_dir = vim.fn.stdpath 'data' .. '/site' }
    treesitter.install(parsers)

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('UserTreesitter', { clear = true }),
      pattern = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'python',
        'lua',
      },
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    require('template-string').setup {}
  end,
}
