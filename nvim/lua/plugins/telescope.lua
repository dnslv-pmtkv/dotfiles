return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'folke/todo-comments.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local telescope = require 'telescope'

    local function opts(desc)
      return {
        desc = 'Telescope: ' .. desc,
        noremap = true,
        silent = true,
        nowait = true,
      }
    end

    vim.keymap.set(
      'n',
      '<C-p>',
      ':Telescope find_files hidden=true no_ignore=true<CR>',
      opts 'Find files'
    )
    vim.keymap.set('n', '<C-f>', ':Telescope live_grep<CR>', opts 'Live grep')

    vim.keymap.set(
      'n',
      '<M-f>',
      ':Telescope current_buffer_fuzzy_find <CR>',
      opts 'Current buffer fuzyz find'
    )

    vim.keymap.set('n', '<leader>fb', ':Telescope buffers <CR>', opts 'Buffers')
    vim.keymap.set(
      'n',
      '<leader>fg',
      ':Telescope git_files<CR>',
      opts 'Git files'
    )
    vim.keymap.set(
      'n',
      '<leader>fr',
      ':Telescope oldfiles<CR>',
      opts 'Recent files'
    )
    vim.keymap.set(
      'n',
      '<leader>ft',
      '<cmd>TodoTelescope<cr>',
      opts 'Find todos'
    )
    vim.keymap.set('n', '<leader>R', ':Telescope resume<CR>', opts 'Resume')
    vim.keymap.set(
      'n',
      '<leader>gr',
      ':Telescope lsp_references<CR>',
      opts 'Lsp references'
    )

    telescope.setup {
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
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

    telescope.load_extension 'fzf'
  end,
}
