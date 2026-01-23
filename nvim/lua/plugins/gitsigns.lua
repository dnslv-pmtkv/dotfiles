return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function opts(desc)
        return {
          desc = desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      vim.keymap.set(
        'n',
        '<leader>hb',
        gs.toggle_current_line_blame,
        opts 'Toggle current line blame'
      )

      vim.keymap.set('n', '<leader>hB', function()
        gs.blame_line { full = true }
      end, opts 'Blame line')

      vim.keymap.set('n', '<leader>hp', gs.preview_hunk, opts 'Preview hunk')
      vim.keymap.set('n', '<leader>hd', gs.diffthis, opts 'Diff this')
      vim.keymap.set('n', '<leader>hr', gs.reset_hunk, opts 'Reset hunk')
      vim.keymap.set('v', '<leader>hr', gs.reset_hunk, opts 'Reset hunk')
    end,
  },
}
