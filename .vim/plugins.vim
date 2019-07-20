let g:closetag_filenames = '*.html,*.html.erb'
let b:lion_squeeze_spaces = 1

let $FZF_DEFAULT_COMMAND = "rg --files --glob '!vendor*'"

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let g:UltiSnipsSnippetDirectories=["my-snippets"]
let g:UltiSnipsExpandTrigger="<leader><Tab>"

call plug#begin()
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
  Plug 'mileszs/ack.vim'          " project search

  Plug 'Shougo/deoplete.nvim'
  Plug 'Shougo/context_filetype.vim'
  Plug 'Shougo/neco-syntax'
  Plug 'wellle/tmux-complete.vim'
  Plug 'zchee/deoplete-go', { 'do': 'make'}
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'

  Plug 'w0rp/ale'

  Plug 'luochen1990/rainbow'      " bracket highlighting
  Plug 'ap/vim-buftabline'        " tabs for open buffers
  Plug 'danro/rename.vim'         " adds the :Rename command

  Plug 'tpope/vim-fugitive'     " git commands
  Plug 'mhinz/vim-signify'      " gutter diff

  Plug 'dietsche/vim-lastplace' " remember last cursor position in file
  Plug 'wellle/targets.vim'     " additional change-inside targets

  Plug 'SirVer/ultisnips'       " snippet engine

  " language plugins
  Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
  Plug 'nsf/gocode', { 'for': 'go', 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

  Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
  Plug 'pearofducks/ansible-vim', { 'for': 'yaml' }
  Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
  Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }

  Plug 'tpope/vim-endwise', { 'for': 'ruby' }
  Plug 'tpope/vim-haml', { 'for': 'haml' }
  Plug 'slim-template/vim-slim', { 'for': 'slim' }
  Plug 'alvan/vim-closetag', { 'for': ['html', 'eruby'] }

  Plug 'idris-hackers/idris-vim', { 'for': ['idris'] }

  Plug 'rodjek/vim-puppet', { 'for': 'puppet' }

  Plug 'kchmck/vim-coffee-script', { 'for': 'coffeescript' }
  Plug 'mxw/vim-jsx', { 'for': 'jsx' }

  Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }

  Plug 'lervag/vimtex', { 'for': 'latex' }

  Plug 'martinda/Jenkinsfile-vim-syntax', { 'for': 'jenkins' }

  Plug 'lepture/vim-jinja', { 'for': 'jinja' }

  Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }

  Plug 'tsandall/vim-rego', { 'for': 'rego' }
  Plug 'posva/vim-vue', { 'for': 'vue' }
call plug#end()
