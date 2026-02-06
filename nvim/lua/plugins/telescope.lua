return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'folke/todo-comments.nvim',
  },
  config = function()
    local telescope = require 'telescope'

    local keymap = vim.keymap.set
    local function opts(desc)
      return {
        desc = 'Telescope: ' .. desc,
        noremap = true,
        silent = true,
        nowait = true,
      }
    end

    keymap(
      'n',
      '<C-p>',
      ':Telescope find_files hidden=true no_ignore=true<CR>',
      opts 'Find files'
    )
    keymap('n', '<leader>fb', ':Telescope buffers <CR>', opts 'Buffers')
    keymap('n', '<leader>fg', ':Telescope git_files<CR>', opts 'Git files')
    keymap('n', '<leader>fr', ':Telescope oldfiles<CR>', opts 'Recent files')
    keymap('n', '<leader>ff', ':Telescope live_grep<CR>', opts 'Live grep')
    keymap('n', '<leader>ft', '<cmd>TodoTelescope<cr>', opts 'Find todos')
    keymap('n', '<leader>R', ':Telescope resume<CR>', opts 'Resume')
    keymap(
      'n',
      '<leader>/',
      ':Telescope current_buffer_fuzzy_find <CR>',
      opts 'Current buffer fuzyz find'
    )
    keymap(
      'n',
      '<leader>gr',
      ':Telescope lsp_references<CR>',
      opts 'Lsp references'
    )

    telescope.setup {
      defaults = {
        sorting_strategy = 'ascending',
        path_display = { 'filename_first' },
        layout_config = { prompt_position = 'top' },
        file_ignore_patterns = {
          '__pycache__',
          'htmlcov',
          'media',
          'static',
          'node_modules',
          'assets',
          'dist',
          '.git',
          '.pytest_cache',
          'android',
          'ios',
          '.expo',
          'vendor',
          '.ruff_cache',
          '.venv',
        },
      },
    }
  end,
}
