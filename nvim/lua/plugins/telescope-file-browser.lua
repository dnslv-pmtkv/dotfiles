return {
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require 'telescope'
    local fb_actions = require 'telescope._extensions.file_browser.actions'

    telescope.setup {
      extensions = {
        file_browser = {
          -- default telesope settings override
          initial_mode = 'normal',
          no_ignore = true,
          hidden = true,

          path = vim.loop.cwd(),
          cwd = vim.loop.cwd(),
          cwd_to_path = false,
          grouped = false,
          files = true,
          add_dirs = true,
          depth = 1,
          auto_depth = false,
          select_buffer = true,
          -- hidden = { file_browser = false, folder_browser = false },
          respect_gitignore = vim.fn.executable 'fd' == 1,
          follow_symlinks = false,
          browse_files = require('telescope._extensions.file_browser.finders').browse_files,
          browse_folders = require(
            'telescope._extensions.file_browser.finders'
          ).browse_folders,
          hide_parent_dir = false,
          collapse_dirs = false,
          prompt_path = false,
          quiet = false,
          dir_icon = '',
          dir_icon_hl = 'Default',
          display_stat = { date = true, size = true, mode = true },
          hijack_netrw = true,
          use_fd = true,
          git_status = true,
          mappings = {
            ['i'] = {
              ['<A-c>'] = fb_actions.create,
              ['<S-CR>'] = fb_actions.create_from_prompt,
              ['<A-r>'] = fb_actions.rename,
              ['<A-m>'] = fb_actions.move,
              ['<A-y>'] = fb_actions.copy,
              ['<A-d>'] = fb_actions.remove,
              ['<C-o>'] = fb_actions.open,
              ['<C-g>'] = fb_actions.goto_parent_dir,
              ['<C-e>'] = fb_actions.goto_home_dir,
              ['<C-w>'] = fb_actions.goto_cwd,
              ['<C-t>'] = fb_actions.change_cwd,
              ['<C-f>'] = fb_actions.toggle_browser,
              ['<C-h>'] = fb_actions.toggle_hidden,
              ['<C-s>'] = fb_actions.toggle_all,
              ['<bs>'] = fb_actions.backspace,
            },
            ['n'] = {
              ['c'] = fb_actions.create,
              ['r'] = fb_actions.rename,
              ['m'] = fb_actions.move,
              ['y'] = fb_actions.copy,
              ['d'] = fb_actions.remove,
              ['o'] = fb_actions.open,
              ['g'] = fb_actions.goto_parent_dir,
              ['e'] = fb_actions.goto_home_dir,
              ['w'] = fb_actions.goto_cwd,
              ['t'] = fb_actions.change_cwd,
              ['f'] = fb_actions.toggle_browser,
              ['h'] = fb_actions.toggle_hidden,
              ['s'] = fb_actions.toggle_all,
            },
          },
        },
      },
    }

    require('telescope').load_extension 'file_browser'
  end,
}
