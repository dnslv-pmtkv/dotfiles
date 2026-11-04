local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes:1'
opt.cursorline = true

opt.backspace = 'indent,eol,start'
opt.clipboard:append 'unnamedplus'
opt.mouse:append 'a'

opt.scrolloff = 7
opt.sidescrolloff = 7

opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.background = 'dark'

opt.swapfile = false
opt.autoread = true

opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.autoindent = true
opt.smartindent = true
opt.wrap = true

opt.updatetime = 100

opt.splitright = true
opt.splitbelow = true

opt.winborder = 'rounded'

-- No automatic comment insertion on new lines
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('UserFormatOptions', { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove { 'r', 'o' }
  end,
})
