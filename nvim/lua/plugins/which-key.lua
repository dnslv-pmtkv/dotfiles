return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    spec = {
      { '<leader>c', group = 'code' },
      { '<leader>f', group = 'find' },
      { '<leader>g', group = 'goto' },
      { '<leader>h', group = 'git hunks' },
      { '<leader>n', group = 'new / no-highlight' },
      { '<leader>p', group = 'pick' },
      { '<leader>r', group = 'rename / restart' },
      { '<leader>s', group = 'splits' },
    },
  },
}
