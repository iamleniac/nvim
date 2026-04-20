-- Disable mouse integration
vim.opt.mouse = ''

-- Block cursor on insert mode
vim.opt.guicursor = ''

-- Line numbers and relative numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- 80 columns
vim.opt.textwidth = 80
vim.opt.colorcolumn = '80'

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Disable highlight on search
vim.opt.hlsearch = false

-- Incremental search highlight
vim.opt.incsearch = true

-- Faster update time (useful for code completion)
vim.opt.updatetime = 50

-- Enable terminal true color
vim.opt.termguicolors = true

-- Remove mode in favour of lualine
vim.opt.showmode = false

-- Enable clipboard yanking and pasting
vim.o.clipboard = 'unnamedplus'

-- Undo file
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

-- Disable backup writing
vim.opt.swapfile = false
vim.opt.writebackup = false
