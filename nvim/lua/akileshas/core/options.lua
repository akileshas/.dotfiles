---@diagnostic disable: assign-type-mismatch
-- display style of file listings
vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- cursor
opt.guicursor = ""
opt.cursorline = true

-- clipboard
opt.clipboard:append("unnamedplus")

-- isfname list
opt.isfname:append("@-@")
opt.isfname:append(".")

-- line number
opt.number = true
opt.relativenumber = true

-- tabs & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- line wrapping
opt.wrap = true
opt.breakindent = true

-- turn off swapfiles and backup
opt.swapfile = false
opt.backup = false

-- modify the undoing of file
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- split windows
opt.splitright = true
opt.splitbelow = true

-- appearance

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.scrolloff = 7
opt.showmode = true

-- performance and timing
opt.updatetime = 100
-- opt.timeoutlen = 1000

-- backspace
opt.backspace = "indent,eol,start"
