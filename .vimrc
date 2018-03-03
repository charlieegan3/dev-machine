" Charlie's Vim Config

syntax enable " turn on syntax highlighting
set background=dark " use a dark background
colorscheme base16-default-dark " use the base16 colorscheme, irrelevant which as inherits from terminal
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

set undofile " maintain undo history
set undodir=~/.vim/.undo/
set backupdir=~/.vim/backup/
set directory=~/.vim/.swp/

set foldenable " enable code folding
set foldmethod=indent " use indentation to fold
set foldlevelstart=2 " start folding after 2 levels of nesting
set foldnestmax=10 " don't nest folds more than 10 times

set number numberwidth=3 " show numbers column

set smarttab smartindent

set backspace=indent,eol,start " backspace behavior

source ~/.vim/ft_overrides.vim
source ~/.vim/mappings.vim
source ~/.vim/plugins.vim
source ~/.vim/autocommands.vim
source ~/.vim/highlighting.vim
