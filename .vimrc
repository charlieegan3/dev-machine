" Charlie's Vim Config

" 'just the essentials'
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
set spell spelllang=en_us " enable spelling highlighting
set scrolloff=5 " keep 5 lines between top/bottom of screen and cursor
set noerrorbells " i don't make mistakes, so I don't need the bells
set colorcolumn=80 " draw a column to guide line length
autocmd Filetype go setlocal colorcolumn=0
set nowrap " don't wrap lines
set lazyredraw " only redraw vim when required
set autowrite " autowrite files allowing switching without saving
set laststatus=0 " don't show the filename at the bottom of window (because it's at the top)

set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

set foldenable " enable code folding
set foldmethod=indent " use indentation to fold
set foldlevelstart=2 " start folding after 2 levels of nesting
set foldnestmax=10 " don't nest folds more than 10 times

set number numberwidth=3 " show numbers column

set smarttab smartindent expandtab " sane tab settings
set tabstop=8 softtabstop=8 shiftwidth=2 " indentation quantities
autocmd Filetype go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

set backspace=indent,eol,start " backspace behavior

" set list " show invisibles, toggled later in autocmd
set listchars=tab:>·,trail:~,extends:>,precedes:<

let mapleader=";"

" color UI elements
highlight StatusLine ctermfg=black ctermbg=white
highlight WildMenu ctermfg=white ctermbg=black
highlight LineNr ctermfg=darkgrey ctermbg=black
highlight SignColumn ctermbg=black " git gutter column
highlight GitGutterAdd ctermbg=black
highlight GitGutterChange ctermbg=black
highlight GitGutterDelete ctermbg=black
highlight GitGutterChangeDelete ctermbg=black
highlight BufTabLineCurrent ctermbg=black
highlight BufTabLineActive ctermbg=white
highlight BufTabLineHidden ctermbg=darkgrey
highlight BufTabLineFill ctermbg=grey
highlight SpellBad ctermbg=darkgrey ctermfg=white cterm=none
highlight SpellLocal ctermbg=darkgrey ctermfg=white cterm=none
highlight SpellRare ctermbg=darkgrey ctermfg=white cterm=none
highlight MatchParen ctermbg=black ctermfg=white cterm=underline
syntax match TrailingWhitespace "\s+$"
highlight TrailingWhitespace ctermbg=darkred

" movement
noremap j gj
noremap k gk
noremap J 5j
noremap K 5k
noremap B ^
noremap E $

" windows
nnoremap <leader>w :bd!<cr>
nnoremap <leader>t :terminal<cr>
nnoremap <leader>n <C-w>v
nnoremap <tab> :bn<cr>
nnoremap <S-tab> :bp<cr>
nnoremap <leader>v :vsp<cr>
nnoremap <leader>rm :call delete(expand('%')) \| bdelete!<CR>

" plugins & shortcuts
nnoremap <SPACE> :FZF<cr>

nnoremap <leader>T :!ctags -R .<cr>
nnoremap <leader><tab> <C-]>
nnoremap <leader>§ <C-t>

nnoremap <leader>f :Autoformat<cr>
nnoremap <leader>g :Gread<cr>

nnoremap <cr> :w<cr>

vnoremap <cr> "+y<cr>
vnoremap <BS> "+p<cr>

" spelling
nnoremap <Left> [s
nnoremap <Right> ]s
nnoremap <Down> :%s /
nnoremap <BS> 1z=

" insert mappings
inoremap kj <esc>
inoremap jk <esc>
inoremap kk <esc>
inoremap jj <esc>
inoremap JJ <esc>
inoremap KK <esc>

" plugin settings
let g:SuperTabCompleteCase = 'ignore'

let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_metalinter_autosave = 1
let g:go_doc_keywordprg_enabled = "0"

let g:NERDSpaceDelims = 1

let g:terraform_fmt_on_save = 1

let $FZF_DEFAULT_COMMAND = 'ag -l -g "" --hidden'

" automatic commands
autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * :Tab2Space

" go
autocmd BufRead,BufNewFile *.go set nolist
" ruby
autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,*.ru,*.rake} set ft=ruby
" conf
autocmd BufRead,BufNewFile {*.conf} set ft=c

if has('nvim')
  tnoremap <S-tab> <C-\><C-n>:bp<cr>

  augroup terminal
    autocmd TermOpen * set bufhidden=hide
    autocmd TermOpen * setlocal nospell
    nnoremap <leader>w <C-c>:bd!<cr>
  augroup END
endif

call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'ervandew/supertab'            " completion
Plug 'rking/ag.vim'                 " project search
Plug 'luochen1990/rainbow'          " bracket highlighting
Plug 'ap/vim-buftabline'            " tabs for open buffers
Plug 'danro/rename.vim'             " adds the :rename command
Plug 'scrooloose/nerdcommenter'     " comment toggling
Plug 'rhlobo/vim-super-retab'       " command to convert tabs to spaces
Plug 'terryma/vim-multiple-cursors' " something a little like sublime

Plug 'tpope/vim-fugitive'           " git commands
Plug 'airblade/vim-gitgutter'       " gutter git status

Plug 'vim-ruby/vim-ruby'            " ruby
Plug 'tpope/vim-endwise'            " ruby end insertion
Plug 'tpope/vim-haml'               " haml
Plug 'kchmck/vim-coffee-script'     " coffeescript
Plug 'fatih/vim-go'                 " golang
Plug 'rust-lang/rust.vim'           " rust
Plug 'yaml.vim'                     " yml
Plug 'mxw/vim-jsx'                  " jsx & React
Plug 'hashivim/vim-terraform'       " terraform fmt

" currently unused
" Plug 'nelstrom/vim-mac-classic-theme' " coolerrs
" Plug 'nathanaelkane/vim-indent-guides' " show indent level
" Plug 'slim-template/vim-slim'
" Plug 'lervag/vimtex'
" Plug 'pearofducks/ansible-vim'
" Plug 'rhysd/vim-crystal'
" Plug 'neo4j-contrib/cypher-vim-syntax'
call plug#end()
