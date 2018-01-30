let g:SuperTabCompleteCase = 'ignore'
let g:closetag_filenames = '*.html,*.html.erb'
let b:lion_squeeze_spaces = 1

let $FZF_DEFAULT_COMMAND = '(git ls-files; git ls-files --others --exclude-standard; git ls-files -d) | sort | uniq -u'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

call plug#begin()
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
  Plug 'mileszs/ack.vim'          " project search
  Plug 'ervandew/supertab'        " completion
  Plug 'luochen1990/rainbow'      " bracket highlighting
  Plug 'ap/vim-buftabline'        " tabs for open buffers
  Plug 'danro/rename.vim'         " adds the :Rename command
  Plug 'scrooloose/nerdcommenter' " comment toggling

  Plug 'tpope/vim-fugitive'     " git commands
  Plug 'airblade/vim-gitgutter' " gutter git status

  Plug 'tpope/vim-sleuth'       " whitespace settings detection
  Plug 'dietsche/vim-lastplace' " remember last cursor position in file
  Plug 'tommcdo/vim-lion'       " auto alignment
  Plug 'wellle/targets.vim'     " additional change-inside targets

  Plug 'alvan/vim-closetag', { 'for': ['html', 'eruby'] }

  Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
  Plug 'pearofducks/ansible-vim', { 'for': 'yaml' }
  Plug 'charlieegan3/vim-terraform', { 'for': 'terraform' }
  Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }

  " Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
  Plug 'tpope/vim-endwise', { 'for': 'ruby' }
  Plug 'tpope/vim-haml', { 'for': 'haml' }
  Plug 'slim-template/vim-slim', { 'for': 'slim' }

  Plug 'fatih/vim-go', { 'for': 'go' }
  Plug 'nsf/gocode', { 'for': 'go', 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

  Plug 'kchmck/vim-coffee-script', { 'for': 'coffeescript' }
  Plug 'mxw/vim-jsx', { 'for': 'jsx' }

  Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }

  Plug 'lervag/vimtex', { 'for': 'latex' }
call plug#end()
