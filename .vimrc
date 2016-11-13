" Charlie's Vim Config

" 'just the essentials'
syntax enable
colorscheme mac_classic
set path=$PWD/**
set nocompatible
set wildmenu
set showmatch
set incsearch
set hlsearch
set spell spelllang=en_us
set autoread
set scrolloff=5
set noerrorbells

set number
set numberwidth=3
highlight LineNr ctermfg=Black ctermbg=LightGrey

set smarttab
set smartindent
set expandtab
set colorcolumn=80
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=2

au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,*.ru,*.rake} set ft=ruby
let g:SuperTabCompleteCase = 'ignore'
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_doc_keywordprg_enabled = "0"
let g:ackprg = 'ag --nogroup --nocolor --column'

let mapleader=";"

let $FZF_DEFAULT_COMMAND = 'find . -type f | grep -v ./.git | grep -v bundle/ | grep -v tmp/ | grep -v venv | grep -v wercker/'

" movement
noremap j gj
noremap k gk
noremap J 5j
noremap K 5k
noremap B ^
noremap E $

" plugins & shortcuts
nnoremap <leader>f :Autoformat<cr>
nnoremap <leader>g :Gread<cr>
nnoremap <leader>p :PlugInstall<cr>
nnoremap <leader>vs :source ~/.vimrc<cr>
nnoremap <leader>t :!ctags -R .<cr>
nnoremap <leader><tab> <C-]>
nnoremap <leader>§ <C-t>
nnoremap <leader>w :bd<cr>
nnoremap <leader>q :wq<cr>

nnoremap <SPACE> :FZF<cr>
nnoremap <tab> :bn<cr>
nnoremap <S-tab> :bp<cr>
nnoremap <cr> :w<cr>
nnoremap <Left> [s
nnoremap <Right> ]s
nnoremap <Up> z=
nnoremap <Down> :%s /
nnoremap <BS> 1z=

" insert mappings
inoremap kj <esc>
inoremap jk <esc>
inoremap kk <esc>
inoremap jj <esc>
inoremap JJ <esc>
inoremap KK <esc>

call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'ervandew/supertab'
Plug 'airblade/vim-gitgutter'
Plug 'itspriddle/vim-stripper'
Plug 'mileszs/ack.vim'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

Plug 'tpope/vim-endwise'
Plug 'https://github.com/slim-template/vim-slim'
Plug 'mattn/emmet-vim'
Plug 'gregsexton/MatchTag'
Plug 'lervag/vimtex'
Plug 'fatih/vim-go'
Plug 'pearofducks/ansible-vim'
Plug 'rhysd/vim-crystal'
Plug 'neo4j-contrib/cypher-vim-syntax'
Plug 'nelstrom/vim-mac-classic-theme'
Plug 'rust-lang/rust.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-haml'
Plug 'kchmck/vim-coffee-script'
Plug 'nathanaelkane/vim-indent-guides'
call plug#end()
