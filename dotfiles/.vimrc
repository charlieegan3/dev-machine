" Charlie's Vim Config

syntax enable " turn on syntax highlighting
set path=$PWD/** " use the current working directory as the path
set nocompatible " disable compatibility features
set wildmenu " show command suggestions
set showmatch " highlight matching parenthesis
set incsearch " search while typing
set hlsearch " mark matches to searches
set ignorecase " Make searches case insensitive
set smartcase " (Unless they contain a capital letter)
set scrolloff=5 " keep 5 lines between top/bottom of screen and cursor
set noerrorbells " i don't make mistakes, so I don't need the bells
set colorcolumn=80 " draw a column to guide line length
set nowrap " don't wrap lines
set lazyredraw " only redraw vim when required
set laststatus=0 " don't show the filename at the bottom of window (because it's at the top)
set ff=unix
set complete-=i
set autowrite " write when closing files, and running build commands
set completeopt=longest,menuone
set encoding=utf-8
set cursorline " show underline for current cursor line

set undofile " maintain undo history
set undodir=~/.vim/.undo/
set backupdir=~/.vim/backup/
set directory=~/.vim/.swp/

set number numberwidth=3 " show numbers column

set shiftwidth=4 " the default is 8?

set smarttab smartindent
set tabstop=4
set list listchars=tab:>-

set backspace=indent,eol,start " backspace behavior

" must be in .vimrc :(
let g:deoplete#enable_at_startup = 1
let g:terraform_fmt_on_save = 1

source ~/.vim/ft_overrides.vim
source ~/.vim/mappings.vim
source ~/.vim/plugins.vim
source ~/.vim/autocommands.vim
source ~/.vim/highlighting.vim
