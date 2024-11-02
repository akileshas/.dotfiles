-- display style of file listings
vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt  -- for conciseness

-- cursor
opt.guicursor = ""
opt.cursorline = true  -- highlight the current cursor line

-- clipboard
opt.clipboard:append("unnamedplus")  -- use system clipboard as default register

-- isfname list
opt.isfname:append("@-@")
opt.isfname:append(".")

-- line number
opt.number = true  -- shows absolute line number on cursor line (when relative number is on)
opt.relativenumber = true  -- show relative line numbers

-- tabs & indentation
opt.tabstop = 4  -- 4 spaces for tabs (prettier default)
opt.softtabstop = 4  -- 4 spaces for tabs and backspace treats the same
opt.shiftwidth = 4  -- 4 spaces for indent width
opt.expandtab = true  -- expand tab to spaces
opt.smartindent = true  -- enables automatic indentation based on the syntax and structure of the code

-- line wrapping
opt.wrap = true  -- enable line wrapping
opt.breakindent = true  -- enables indented wrapping

-- turn off swapfiles and backup
opt.swapfile = false
opt.backup = false

-- modify the undoing of file
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"  -- sets the directory for storing undo history files
opt.undofile = true  -- enables persistent undo, allowing you to undo changes even after closing and reopening files

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.incsearch = true  -- enables incremental search, so matches are highlighted as you type.
opt.hlsearch = true  -- enables highlighting of all search matches

-- split windows
opt.splitright = true  -- split vertical window to the right
opt.splitbelow = true  -- split horizontal window to the bottom

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark"  -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"  -- show sign column so that text doesn't shift
opt.scrolloff = 11  -- ensures a minimum of 11 lines above and below the cursor
opt.showmode = true  -- shows the mode display

-- performance and timing
opt.updatetime = 100
opt.timeoutlen = 1000

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
