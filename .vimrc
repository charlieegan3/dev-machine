" 'just the essentials'
syntax enable
set path=$PWD/**
set nocompatible
set wildmenu
set showmatch
set incsearch
set hlsearch
set spell spelllang=en_us

set number
set relativenumber
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
let g:go_doc_keywordprg_enabled = "0"

let mapleader=";"

" movement
noremap j gj
noremap k gk
noremap J 5j
noremap K 5k
noremap B ^
noremap E $

" plugins & shortcuts
nnoremap <leader>f :Ack
nnoremap <leader>c :TComment<cr>
nnoremap <leader>vs :source %<cr>

nnoremap <SPACE> :FZF<cr>
nnoremap <tab> :bn<cr>
nnoremap <cr> :w<cr>
nnoremap <Left>  [s
nnoremap <Right> ]s
nnoremap <Up>    z=
nnoremap <Down>  :%s /
nnoremap <BS> 1z=

" insert mappings
inoremap kj <esc>
inoremap jk <esc>

" visual mappings
vnoremap v <Plug>(expand_region_expand)
vnoremap V <Plug>(expand_region_shrink)
vnoremap . :norm.<CR>

call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'mileszs/ack.vim'
Plug 'ervandew/supertab'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-expand-region'

Plug 'tomtom/tcomment_vim'
Plug 'itspriddle/vim-stripper'

Plug 'tpope/vim-endwise'
Plug 'https://github.com/slim-template/vim-slim'
Plug 'mattn/emmet-vim'
Plug 'lervag/vimtex'
Plug 'fatih/vim-go'

Plug 'wakatime/vim-wakatime'
call plug#end()
