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
opt.numberwidth = 4
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

-- split windows
opt.splitkeep = "screen"
opt.splitright = true
opt.splitbelow = true

-- markdown settings
opt.conceallevel = 0

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.showcmd = true
opt.showmode = false
opt.showmatch = true
opt.ruler = true
opt.showtabline = 1
opt.laststatus = 3
opt.cmdheight = 0
opt.scrolloff = 11
opt.sidescrolloff = 11
opt.sidescroll = 11
opt.pumheight = 21
opt.pumwidth = 21
opt.pumblend = 0
opt.wildmenu = true
opt.winblend = 0
opt.colorcolumn = "108"
opt.signcolumn = "yes:1"
opt.wildmode = "longest:full,full"
opt.completeopt = "menuone,noselect,preview"

-- completion settings
opt.complete = ".,w,b,u,t,i"

-- performance and timing
opt.updatetime = 100
opt.timeoutlen = 3000
opt.ttimeoutlen = 0
opt.redrawtime = 10000
opt.lazyredraw = true
opt.ttyfast = true
