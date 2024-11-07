" ==========================
" General Settings
" ==========================
" Enable line numbers and relative line numbers
set number               " Absolute line numbers
set relativenumber       " Relative line numbers

" Enable syntax highlighting
syntax enable

" Set background color (for dark mode)
set background=dark

" Highlight search matches
set hlsearch

" Enable line break at word boundaries
set linebreak

" Enable 24-bit RGB color support in the terminal
set termguicolors

" ==========================
" Indentation Settings
" ==========================
" Set auto-indentation (for programming languages)
filetype indent on       " Enable file type specific indentation
set smartindent          " Enable smart indentation
set autoindent           " Enable auto-indentation
set tabstop=4            " Set tab width to 4 spaces
set shiftwidth=4         " Set number of spaces to indent
set expandtab            " Use spaces instead of tabs

" ==========================
" Line Wrapping and Indentation
" ==========================
" Enable line wrapping
set wrap

" Enable break indent (for wrapped lines)
set breakindent
set showbreak=↪\       " Optional: Use a symbol (e.g., ↪) to indicate wrapped lines

" ==========================
" Search Settings
" ==========================
" Highlight search results as you type
set incsearch

" Ignore case in searches
set ignorecase

" Enable smart case in searches
set smartcase

" ==========================
" Status Line and Information
" ==========================
" Show line and column number in the status line
set ruler

" Show the current file name, path, and other information in the status line
set statusline=%f\ %y\ %m\ %=Line\ %l/%L\ Col\ %c

" Show cursor position in the status line
set laststatus=2

" ==========================
" Clipboard and File Handling
" ==========================
" Enable clipboard support (requires Vim to be compiled with +clipboard)
set clipboard=unnamedplus

" Disable swap files
set noswapfile

" Disable backup files
set nobackup
set nowritebackup

" Set undo directory
set undodir=~/.vim/undo//

" Enable persistent undo
set undofile

" ==========================
" Mouse Support
" ==========================
" Enable mouse support (works in normal, insert, and visual mode)
set mouse=a
