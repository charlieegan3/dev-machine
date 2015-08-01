" 'just the essentials'
set path=$PWD/**
set backspace=indent,eol,start
syntax on

" tabs and space settings
set tabstop=2
set shiftwidth=2
set expandtab

" set the space key as the leader (mapleader didn't seem to work)
map <SPACE> <leader>

" leader commands
map <leader>q :wq<cr>
map <leader>w :w<cr>
map <leader>v :edit $MYVIMRC<cr>
map <leader>vs :source %<cr>

map <leader>f :FZF<cr>
map <leader>F :Ack
map <leader>c :TComment<cr>
map <leader>o :NERDTreeToggle<cr>

map <leader>d Yp
map <leader>b ^
map <leader>w $

vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'https://github.com/mhinz/vim-startify'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'tomtom/tcomment_vim'
Plug 'terryma/vim-expand-region'
Plug 'ervandew/supertab'
call plug#end()

" read these other files as Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,*.ru,*.rake} set ft=ruby

" strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" statusline
set statusline=%t%m\ %=%v\ %-6Y
set laststatus=2

" line number & gutter settings
set number
set relativenumber
set numberwidth=3
highlight LineNr ctermfg=Black ctermbg=LightGrey

" g:* settings
let g:SuperTabCompleteCase = 'ignore'
