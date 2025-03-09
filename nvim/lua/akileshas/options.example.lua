-- for convenience
local opt = vim.opt
local indent = 4

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
opt.numberwidth = 1
opt.relativenumber = true

-- tabs & indentation
opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent
opt.shiftround = true
opt.expandtab = true
opt.smarttab = true
opt.smartindent = true
opt.autoindent = true

-- line wrapping
opt.wrap = true
opt.textwidth = 108
opt.linebreak = true
opt.breakindent = true
opt.showbreak = "↪\\ "

-- turn off swapfiles and backup
opt.swapfile = false
opt.backup = false
opt.writebackup = false

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

-- for markdown
opt.conceallevel = 0

-- appearance
opt.showcmd = true
opt.laststatus = 3
opt.showtabline = 1
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes:1"
opt.scrolloff = 11
opt.sidescroll = 11
opt.sidescrolloff = 11
opt.showmode = false
opt.ruler = true
opt.colorcolumn = "+3"

-- performance and timing
opt.updatetime = 100
opt.timeoutlen = 3000
opt.ttimeoutlen = 0
opt.redrawtime = 10000

-- backspace
opt.backspace = "indent,eol,start"

-- cmd height and width
opt.cmdheight = 0

-- alter the listchars
opt.list = true
opt.listchars = {
	trail = "+",
	space = "·",
	nbsp = "␣",
	eol = "↩",
	tab = "▸ ",
	extends = "»",
	precedes = "«",
}
opt.fillchars:append({
	eob = " ",
	lastline = "↓",
})
opt.iskeyword:append("-")

-- mouse support
opt.mouse = "a"

-- show matching brackets
opt.showmatch = true

-- action confirmation
opt.confirm = true

-- Suppress the intro splash screen
opt.shortmess:append("I")

-- completion options
opt.wildmode = "longest:full,full"
opt.completeopt = "menuone,longest,preview"
opt.pumheight = 21

-- setting local config
opt.exrc = true
opt.secure = true

-- set the shell
opt.shell = "/bin/bash"

-- set the shell for the terminal
opt.shellcmdflag = "-c"

-- scrollback buffer
opt.scrollback = 10000000

-- navigation
opt.startofline = true
opt.jumpoptions = "stack"

return {}
