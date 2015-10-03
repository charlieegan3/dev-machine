" 'just the essentials'
set path=$PWD/**
syntax on
set nocompatible
set backspace=indent,eol,start
set colorcolumn=80

" tabs and space settings
set tabstop=2
set shiftwidth=2
set expandtab

let mapleader=";"

map <leader>f :Ack
map <leader>c :TComment<cr>
map <leader>vs :source %<cr>

map <SPACE> :FZF<cr>
map <tab> :bn<cr>
map <cr> :w<cr>

map J 5j
map K 5k
map H ^
map L $
map <c-k> :m .-2<CR>==
map <c-j> :m .+1<CR>==
map <c-l> >>
map <c-h> <<

noremap <Left>  <NOP>
noremap <Right> <NOP>
noremap <Up>    <NOP>
noremap <Down>  <NOP>

vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

call plug#begin()
Plug 'https://github.com/mhinz/vim-startify'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'mileszs/ack.vim'
Plug 'ervandew/supertab'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-expand-region'

Plug 'tomtom/tcomment_vim'
Plug 'itspriddle/vim-stripper'
Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-endwise'
Plug 'https://github.com/slim-template/vim-slim'
Plug 'mattn/emmet-vim'
Plug 'lervag/vimtex'

Plug 'wakatime/vim-wakatime'
call plug#end()

" read these other files as Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,*.ru,*.rake} set ft=ruby

" line number & gutter settings
set number
set relativenumber
set numberwidth=3
highlight LineNr ctermfg=Black ctermbg=LightGrey

" g:* settings
let g:SuperTabCompleteCase = 'ignore'
