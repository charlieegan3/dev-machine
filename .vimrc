" Charlie's Vim Config

let mapleader=";"

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
set scrolloff=5 " keep 5 lines between top/bottom of screen and cursor
set noerrorbells " i don't make mistakes, so I don't need the bells
set colorcolumn=80 " draw a column to guide line length
set nowrap " don't wrap lines
set lazyredraw " only redraw vim when required
set laststatus=0 " don't show the filename at the bottom of window (because it's at the top)
set ff=unix

set undofile " maintain undo history
set undodir=~/.vim/.undo/
set backupdir=~/.vim/backup/
set directory=~/.vim/.swp/

set foldenable " enable code folding
set foldmethod=indent " use indentation to fold
set foldlevelstart=2 " start folding after 2 levels of nesting
set foldnestmax=10 " don't nest folds more than 10 times

set number numberwidth=3 " show numbers column

set smarttab smartindent expandtab " sane tab settings
set tabstop=8 softtabstop=8 shiftwidth=2 " indentation quantities

set backspace=indent,eol,start " backspace behavior

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
highlight SpellBad ctermbg=240 ctermfg=white cterm=none
highlight SpellLocal ctermbg=240 ctermfg=white cterm=none
highlight SpellRare ctermbg=240 ctermfg=white cterm=none
highlight MatchParen ctermbg=black ctermfg=white cterm=underline
highlight Search ctermbg=240 ctermfg=148
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
nnoremap <leader>q :silent exec "wa" \| silent exec "qall"<cr>
nnoremap <leader>w :up\|bd!<cr>
nnoremap <tab> :up\|bn<cr>
nnoremap <S-tab> :up\|bp<cr>
nnoremap <leader>dd :call delete(expand('%')) \| bdelete!<CR>

" shortcuts
nnoremap <SPACE> :FZF<cr>
nnoremap <leader>cc :NERDComToggleComment<cr>

" goto
nnoremap <leader>T :!ctags -R .<cr>
nnoremap <leader><tab> <C-]>

" saving
nnoremap <cr> :up<cr>

" clipboard
vnoremap <cr> "+y<cr>
vnoremap <BS> "+p<cr>

" spelling
nnoremap <Left> [s
nnoremap <Right> ]s
nnoremap <BS> 1z=

" replacing
nnoremap <Down> :%s /

" insert mappings
inoremap kj <esc>
inoremap jk <esc>
inoremap kk <esc>
inoremap jj <esc>
inoremap JJ <esc>
inoremap KK <esc>

" global plugin settings
let g:SuperTabCompleteCase = 'ignore'
let g:closetag_filenames = '*.html,*.html.erb'

let $FZF_DEFAULT_COMMAND = '(git ls-files; git ls-files --others --exclude-standard)'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" automatic commands
" whitespace fixes
autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * :Tab2Space

" clear search
autocmd BufRead,BufEnter * :let @/ = ""
autocmd InsertLeave * :setlocal hlsearch
autocmd InsertEnter * :setlocal nohlsearch

" create paths before save
autocmd BufWritePre * :silent !mkdir -p %:p:h

" filetype help
autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,*.ru,*.rake,*.json.jbuilder} set ft=ruby
autocmd BufRead,BufNewFile {*.conf} set ft=c

call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'ervandew/supertab'            " completion
Plug 'mileszs/ack.vim'              " project search
Plug 'luochen1990/rainbow'          " bracket highlighting
Plug 'ap/vim-buftabline'            " tabs for open buffers
Plug 'danro/rename.vim'             " adds the :Rename command
Plug 'scrooloose/nerdcommenter'     " comment toggling
Plug 'rhlobo/vim-super-retab'       " command to convert tabs to spaces

Plug 'tpope/vim-fugitive'           " git commands
Plug 'airblade/vim-gitgutter'       " gutter git status

Plug 'alvan/vim-closetag', { 'for': ['html', 'eruby'] }

Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
Plug 'pearofducks/ansible-vim', { 'for': 'yaml' }
Plug 'charlieegan3/vim-terraform', { 'for': 'terraform' }
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }

Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-endwise', { 'for': 'ruby' }
Plug 'tpope/vim-haml', { 'for': 'haml' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }

Plug 'kchmck/vim-coffee-script', { 'for': 'coffeescript' }
Plug 'mxw/vim-jsx', { 'for': 'jsa' }

Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'nsf/gocode', { 'for': 'go', 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }

Plug 'lervag/vimtex', { 'for': 'latex' }
call plug#end()
