vim.g.mapleader = ' '

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

map('n', '<leader>a', 'ggVG', 'Select all')

-- Navigate windows
map('n', '<C-h>', '<C-w>h', 'Window left')
map('n', '<C-j>', '<C-w>j', 'Window down')
map('n', '<C-k>', '<C-w>k', 'Window up')
map('n', '<C-l>', '<C-w>l', 'Window right')

-- Navigate buffers
map('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', 'Next buffer')
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', 'Previous buffer')
map('n', '<leader>pb', '<cmd>BufferLinePick<CR>', 'Pick buffer')
map('n', '<leader>N', '<cmd>enew<CR>', 'New buffer')
map('n', '<leader>q', '<cmd>bp|bd#<CR>', 'Close buffer')

-- Keep the cursor centred on big vertical jumps
map('n', '<C-u>', '<C-u>zz', 'Half page up')
map('n', '<C-d>', '<C-d>zz', 'Half page down')
map('n', 'n', 'nzzzv', 'Next match')
map('n', 'N', 'Nzzzv', 'Previous match')
map('n', '}', '}zzzv', 'Next paragraph')
map('n', '{', '{zzzv', 'Previous paragraph')

-- Undo break-points
map('i', ',', ',<c-g>u', 'Comma with undo break')
map('i', '.', '.<c-g>u', 'Period with undo break')
map('i', ';', ';<c-g>u', 'Semicolon with undo break')

-- Move text up and down
map('n', '<A-j>', '<cmd>m .+1<CR>==', 'Move line down')
map('n', '<A-k>', '<cmd>m .-2<CR>==', 'Move line up')
map('x', '<A-j>', ":move '>+1<CR>gv=gv", 'Move selection down')
map('x', '<A-k>', ":move '<-2<CR>gv=gv", 'Move selection up')

-- Better indenting
map('x', '<', '<gv', 'Indent left')
map('x', '>', '>gv', 'Indent right')

-- Paste over a selection without overwriting the register
map('x', 'p', 'P', 'Paste without yanking')

map('n', '<leader>nh', '<cmd>nohlsearch<CR>', 'Clear search highlight')

-- Splits
map('n', '<leader>sv', '<C-w>v', 'Split window vertically')
map('n', '<leader>sh', '<C-w>s', 'Split window horizontally')
map('n', '<leader>se', '<C-w>=', 'Make splits equal size')
map('n', '<leader>sI', '10<C-w>+', 'Increase split height')
map('n', '<leader>sD', '10<C-w>-', 'Decrease split height')
map('n', '<leader>si', '10<C-w>>', 'Increase split width')
map('n', '<leader>sd', '10<C-w><', 'Decrease split width')
map('n', '<leader>sx', '<cmd>close<CR>', 'Close current split')

-- Go to definition in a split
map('n', '<leader>gv', function()
  vim.cmd 'vsplit'
  vim.lsp.buf.definition()
end, 'Definition in vertical split')
map('n', '<leader>gs', function()
  vim.cmd 'split'
  vim.lsp.buf.definition()
end, 'Definition in horizontal split')

map('n', '<leader>cf', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, 'Format buffer')

-- Disable recording macros
map('n', 'q', '<Nop>', 'Disabled')
map('n', 'Q', '<Nop>', 'Disabled')

map('n', '<leader>nf', function()
  local dir = vim.fn.expand '%:h' .. '/'
  local filename = vim.fn.input('New file name: ', dir, 'file')
  if filename ~= '' then
    vim.cmd.edit(filename)
    vim.cmd.write()
  end
end, 'Create new file in current dir')

map('n', '<leader>rf', function()
  local old_name = vim.fn.expand '%:p'
  local new_name = vim.fn.input('Rename to: ', old_name, 'file')
  if new_name ~= '' and new_name ~= old_name then
    vim.fn.mkdir(vim.fn.fnamemodify(new_name, ':h'), 'p')
    os.rename(old_name, new_name)
    vim.cmd.edit(new_name)
    vim.cmd 'bdelete! #'
    print('Renamed to ' .. new_name)
  end
end, 'Rename current file')
