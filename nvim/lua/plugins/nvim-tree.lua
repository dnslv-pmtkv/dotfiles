return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      local api = require 'nvim-tree.api'
      vim.keymap.set('n', '<C-b>', api.tree.toggle)

      local function my_on_attach(bufnr)
        local function opts(desc)
          return {
            desc = 'nvim-tree: ' .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts 'Open')
        vim.keymap.set(
          'n',
          'h',
          api.node.navigate.parent_close,
          opts 'Close Directory'
        )
        vim.keymap.set(
          'n',
          '<C-v>',
          api.node.open.vertical,
          opts 'Open: Vertical Split'
        )
        vim.keymap.set(
          'n',
          '<C-x>',
          api.node.open.horizontal,
          opts 'Open: Horizontal Split'
        )
        vim.keymap.set('n', 'a', api.fs.create, opts 'Create')
        vim.keymap.set('n', 'c', api.fs.copy.node, opts 'Copy')
        vim.keymap.set('n', 'd', api.fs.remove, opts 'Delete')
        vim.keymap.set('n', 'D', api.fs.trash, opts 'Trash')
        vim.keymap.set('n', 'f', api.live_filter.start, opts 'Filter')
        vim.keymap.set(
          'n',
          'gy',
          api.fs.copy.absolute_path,
          opts 'Copy Absolute Path'
        )
        vim.keymap.set('n', 'r', api.fs.rename, opts 'Rename')
        vim.keymap.set('n', 'x', api.fs.cut, opts 'Cut')
        vim.keymap.set('n', 'y', api.fs.copy.filename, opts 'Copy Name')
        vim.keymap.set(
          'n',
          'Y',
          api.fs.copy.relative_path,
          opts 'Copy Relative Path'
        )
        vim.keymap.set('n', 'p', api.fs.paste, opts 'Paste')
        vim.keymap.set('n', '<Tab>', api.node.open.preview, opts 'Open Preview')
      end

      require('nvim-tree').setup {
        on_attach = my_on_attach,
        open_on_tab = true,
        hijack_cursor = true,
        hijack_directories = {
          enable = false,
        },
        view = { width = 42 },
        filters = {
          custom = { '^.git$', '__pycache__' },
        },
        actions = {
          open_file = { quit_on_open = true },
          change_dir = { enable = false },
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
        git = {
          enable = true,
          ignore = false,
        },
        renderer = {
          root_folder_label = false,
          indent_markers = {
            enable = true,
          },
          icons = {
            glyphs = {
              git = {
                unstaged = '',
                staged = 'S',
                unmerged = '',
                renamed = '➜',
                untracked = 'U',
                deleted = '',
                ignored = '◌',
              },
            },
          },
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
          },
        },
      }
    end,
  },
}
