local indent = 4

-- for convenience
local opt = vim.opt

-- cursor
opt.guicursor = ""
opt.cursorline = true

-- clipboard
opt.clipboard = "unnamedplus"

-- isfname list
opt.isfname:append("@-@")
opt.isfname:append(".")

-- title
opt.title = true
opt.titlelen = 0
opt.titlestring = "[nvim](%f)"

-- line number
opt.number = true
opt.numberwidth = 5
opt.relativenumber = true

-- tabs & indentation
opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent
opt.shiftround = true
opt.smarttab = true
opt.smartindent = true
opt.autoindent = true

-- line wrapping
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.showbreak = "↪\\ "

-- turn off swapfiles and backup
opt.swapfile = false
opt.backup = false

-- modify the undoing of file
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- search settings
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
