set path=$PWD/**
set backspace=indent,eol,start
syntax on
set tabstop=2
set shiftwidth=2

command! F :FZF
command! EE :edit $MYVIMRC
command! NN :NERDTreeToggle

au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,*.ru,*.rake,*.rabl} set ft=ruby

" Strip Trailing Whitespace {{{1
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'https://github.com/mhinz/vim-startify'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
call plug#end()

" statusline
set statusline=%t%m\ %=%v\ %-6Y
set laststatus=2

" line number settings
set number
set relativenumber
set numberwidth=3
highlight LineNr ctermfg=Black ctermbg=LightGrey

" set leader
let mapleader = "\<Space>"
