-- for convenience
local opt = vim.opt

local indent = 4

-- cursor settings
opt.guicursor = ""
opt.cursorline = true

-- clipboard settings
opt.clipboard = "unnamedplus"

-- isfname list
opt.isfname:append("@-@")
opt.isfname:append(".")

-- title settings
opt.title = true
opt.titlelen = 0
opt.titlestring = "[nvim](%f)"

-- line number settings
opt.number = true
opt.numberwidth = 5
opt.relativenumber = true

-- indentation settings
opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent
opt.shiftround = true
opt.smarttab = true
opt.smartindent = true
opt.autoindent = true
opt.expandtab = true

-- line wrapping settings
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.showbreak = "↪\\ "

-- disable swapfile and backup
opt.swapfile = false
opt.backup = false

-- undo settings
opt.undofile = true
opt.undolevels = 1000000000
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- search settings
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- split window settings
opt.splitkeep = "screen"
opt.splitright = true
opt.splitbelow = true

-- markdown settings
opt.conceallevel = 0

-- appearance settings
opt.termguicolors = true
opt.background = "dark"
opt.showcmd = true
opt.showmode = false
opt.showmatch = true
opt.ruler = true
opt.showtabline = 1
opt.laststatus = 3
opt.cmdheight = 1
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

-- performance and timing settings
opt.updatetime = 100
opt.timeoutlen = 3000
opt.ttimeoutlen = 0
opt.redrawtime = 10000
opt.ttyfast = true

-- backspace settings
opt.backspace = "indent,eol,start"

-- listchars settings
opt.list = true
opt.listchars = {
    trail = "+",
    space = " ",
    nbsp = "␣",
    eol = "↩",
    tab = "› ",
    extends = "»",
    precedes = "«",
}
opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

-- mouse settings
opt.mouse = "a"

-- confirm dialog settings
opt.confirm = true

-- message settings
opt.shortmess:append("csI")

-- shell settings
opt.shell = "/bin/bash"
opt.shellcmdflag = "-c"
opt.shellquote = ""
opt.shellxquote = ""

-- navigation settings
opt.startofline = true
opt.jumpoptions = "stack"
opt.virtualedit = "block"

-- scroll settings
opt.smoothscroll = true

-- fold settings
opt.foldenable = true
opt.foldlevel = 999
opt.foldmethod = "expr"
opt.foldexpr = [[v:lua.require("akileshas.utils").foldexpr()]]
opt.foldtext = [[v:lua.require("akileshas.utils").foldtext()]]

return {}
