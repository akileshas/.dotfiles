vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- cursor
opt.guicursor = ""
opt.cursorline = true

-- clipboard
-- opt.clipboard:append("unnamedplus")

-- isfname list
opt.isfname:append("@-@")
opt.isfname:append(".")

-- title
opt.title = true
opt.titlestring = "%f // nvim"
-- opt.tabline = "%t"

-- line number
opt.number = true
opt.relativenumber = true

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smarttab = true
opt.smartindent = true
opt.autoindent = true

-- spell checking
-- opt.spell = true

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
opt.undodir = { os.getenv("HOME") .. "/.vim/undodir" }

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
opt.signcolumn = "yes:1"
opt.scrolloff = 7
opt.sidescrolloff = 7
opt.showmode = false

-- performance and timing
opt.updatetime = 100
-- opt.timeoutlen = 1000
opt.redrawtime = 10000

-- backspace
opt.backspace = "indent,eol,start"

-- cmd height and width
opt.cmdheight = 1

-- alter the listchars
opt.list = true
opt.listchars = { trail = " ", eol = "↩", tab = "▸ " }
opt.fillchars:append("eob: ")

-- mouse support
opt.mouse = "a"
opt.mousemoveevent = true

-- show matching brackets
opt.showmatch = true

-- action confirmation
opt.confirm = true

-- Suppress the intro splash screen
opt.shortmess:append("I")

-- completion options
opt.wildmode = "longest:full,full"
opt.completeopt = "menuone,longest,preview"
opt.pumheight = 11

-- open local files
opt.exrc = true
opt.secure = true

-- set the shell
opt.shell = "/bin/bash"

-- set the shell for the terminal
opt.shellcmdflag = "-c"

-- preview of the command
-- opt.inccommand = "split"
