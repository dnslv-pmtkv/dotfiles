vim.g.mapleader = ' '

local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>a', 'ggVG')

-- Navigate windows
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Navigate buffers
vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', opts)
vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', opts)
vim.keymap.set(
  'n',
  '<leader>pb',
  '<cmd>BufferLinePick<CR>',
  { desc = 'Pick buffer' }
)

-- Better vertical movements
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)
vim.keymap.set('n', '}', '}zzzv', opts)
vim.keymap.set('n', '{', '{zzzv', opts)

-- New buffer
vim.keymap.set('n', '<leader>N', ':enew<CR>', opts)

-- Add undo break-points
vim.keymap.set('i', ',', ',<c-g>u', opts)
vim.keymap.set('i', '.', '.<c-g>u', opts)
vim.keymap.set('i', ';', ';<c-g>u', opts)

-- Move text up and down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', opts)
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', opts)
vim.keymap.set('v', '<A-j>', ':m .+1<CR>==', opts)
vim.keymap.set('v', '<A-k>', ':m .-2<CR>==', opts)
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)

-- Clear highlights
vim.keymap.set('n', '<leader>nh', ':noh <CR>', opts)

-- Splits
vim.keymap.set(
  'n',
  '<leader>sv',
  '<C-w>v',
  { desc = 'Split window vertically' }
)
vim.keymap.set(
  'n',
  '<leader>sh',
  '<C-w>s',
  { desc = 'Split window horizontally' }
)
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' })
vim.keymap.set(
  'n',
  '<leader>sI',
  '10<C-w>-',
  { desc = 'Increase split height' }
)
vim.keymap.set(
  'n',
  '<leader>sD',
  '10<C-w>+',
  { desc = 'Descrease split height' }
)
vim.keymap.set(
  'n',
  '<leader>sd',
  '10<C-w><',
  { desc = 'Descrease split width' }
)
vim.keymap.set('n', '<leader>si', '10<C-w>>', { desc = 'Increase split width' })
vim.keymap.set(
  'n',
  '<leader>sx',
  '<cmd>close<CR>',
  { desc = 'Close current split' }
)

vim.keymap.set('n', 'gv', ':vs | lua vim.lsp.buf.definition()<CR>', opts)
vim.keymap.set('n', 'gh', ':split | lua vim.lsp.buf.definition()<CR>', opts)

vim.keymap.set('v', 'p', 'pgvy', opts)

-- Format document
vim.keymap.set(
  'n',
  '<C-f>',
  ':lua vim.lsp.buf.format { async = true }<CR>',
  opts
)

-- better indenting
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- disable recording macros
vim.keymap.set('n', 'q', '<Nop>', opts)
vim.keymap.set('n', 'Q', '<Nop>', opts)

vim.keymap.set('n', '<leader>nf', function()
  -- Get current buffer's directory
  local dir = vim.fn.expand '%:h' .. '/'

  local filename = vim.fn.input('New file name: ', dir, 'file')

  if filename ~= '' then
    vim.cmd('edit ' .. filename) -- :e %:h/filename
    vim.cmd 'write' -- :w
  end
end, { desc = 'Create new file in current dir' })

vim.keymap.set('n', '<leader>rf', function()
  local old_name = vim.fn.expand '%:p' -- full path of current file
  local new_name = vim.fn.input('Rename to: ', old_name, 'file')

  if new_name ~= '' and new_name ~= old_name then
    -- Ensure parent directory exists
    vim.fn.mkdir(vim.fn.fnamemodify(new_name, ':h'), 'p')

    -- Rename the file
    os.rename(old_name, new_name)
    vim.cmd('edit ' .. new_name)

    -- Delete the old buffer (avoid [deleted] buffer lingering)
    vim.cmd 'bdelete! #'

    print('Renamed to ' .. new_name)
  end
end, { desc = 'Rename current file' })
