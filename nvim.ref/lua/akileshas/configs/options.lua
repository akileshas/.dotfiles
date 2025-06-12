local opt = vim.opt

local indent = 4

-- appearance
opt.background = "dark"
opt.cmdheight = 1
opt.colorcolumn = "108"
opt.completeopt = "menu,menuone,noselect,preview"
opt.inccommand = "nosplit"
opt.laststatus = 3
opt.pumblend = 0
opt.pumheight = 21
opt.pumwidth = 21
opt.ruler = false
opt.scrolloff = 11
opt.showcmd = true
opt.showmatch = false
opt.showmode = false
opt.showtabline = 1
opt.signcolumn = "yes:1"
opt.sidescroll = 11
opt.sidescrolloff = 11
opt.tabline = [[%!v:lua.require("akileshas.utils.ui").tabline()]]
opt.termguicolors = true
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.winblend = 0
opt.winheight = 1
opt.winminheight = 1
opt.winminwidth = 5
opt.winwidth = 20

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard = "unnamedplus"

-- completion
opt.complete = ".,w,b,u,t,i"

-- confirm dialogs
opt.confirm = true

-- cursor
opt.cursorline = true
opt.guicursor = ""

-- filename rules
opt.isfname:append("@-@")
opt.isfname:append(".")

-- folds
opt.foldenable = true
opt.foldexpr = [[v:lua.require("akileshas.utils.ui").foldexpr()]]
opt.foldlevel = 999
opt.foldmethod = "expr"
opt.foldtext = [[v:lua.require("akileshas.utils.ui").foldtext()]]

-- grep
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- indentation
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = indent
opt.shiftround = true
opt.smartindent = true
opt.smarttab = true
opt.softtabstop = indent
opt.tabstop = indent

-- line numbers
opt.number = true
opt.numberwidth = 5
opt.relativenumber = true

-- list chars
opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}
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

-- markdown
opt.conceallevel = 0
opt.spelllang = { "en" }

-- messages
opt.shortmess:append({
    I = true,
})

-- mouse
opt.mouse = "a"

-- navigation
opt.jumpoptions = "view"
opt.startofline = true
opt.virtualedit = "block"

-- scrolling
opt.smoothscroll = true

-- search
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true

-- session
opt.sessionoptions = {
    "blank",
    "buffers",
    "curdir",
    "folds",
    "globals",
    "help",
    "skiprtp",
    "tabpages",
    "terminal",
    "winsize",
}

-- shell
opt.shell = "/bin/bash"
opt.shellcmdflag = "-c"
opt.shellquote = ""
opt.shellxquote = ""

-- splits
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true

-- swap and backup
opt.backup = false
opt.swapfile = false

-- timing and performance
opt.redrawtime = 10000
opt.timeoutlen = 3000
opt.ttimeoutlen = 0
opt.ttyfast = true
opt.updatetime = 100

-- title
opt.title = true
opt.titlelen = 0
opt.titlestring = "[nvim](%f)"

-- undo
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.undolevels = 100000

-- wrapping
opt.breakindent = true
opt.linebreak = true
opt.showbreak = "↪\\ "
opt.wrap = true

return {}
