-- Style fot the netrw
vim.cmd("let g:netrw_liststyle = 3")

-- for convenience
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
-- opt.titlestring = "%f // nvim"
opt.titlelen = 0
opt.titlestring = "[nvim](%f)"
-- opt.tabline = "%t"

-- line number
opt.number = true
opt.numberwidth = 1
opt.relativenumber = true

-- tabs & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
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
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- split windows
opt.splitright = true
opt.splitbelow = true

-- appearance
opt.showcmd = true
opt.laststatus = 3
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes:1"
opt.showmode = false
opt.scrolloff = 11
opt.sidescroll = 11
opt.sidescrolloff = 11
opt.textwidth = 108
opt.colorcolumn = "+3"

-- opt.foldcolumn = '0'
-- opt.foldenable = true
-- opt.foldlevel = 99
-- opt.foldlevelstart = 99
-- opt.foldmethod = 'expr'
-- opt.foldtext = ''
-- vim.opt.signcolumn = "yes"
-- vim.opt.foldcolumn = "1"
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 99
-- vim.opt.foldenable = true
-- vim.wo.foldmethod = "expr" -- Set foldmethod to expr
-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.fillchars = { fold = " ", foldopen = "", foldsep = " ", foldclose = "" }

-- performance and timing
opt.updatetime = 100
-- opt.timeoutlen = 1000
opt.ttimeoutlen = 0
opt.redrawtime = 10000

-- backspace
opt.backspace = "indent,eol,start"

-- cmd height and width
opt.cmdheight = 1

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
