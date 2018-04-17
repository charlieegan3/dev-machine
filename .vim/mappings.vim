let mapleader=";"

" movement
noremap j gj
noremap k gk
noremap B 0
noremap E $

" quit vim
nnoremap <leader>q :silent exec "wa" \| silent exec "qall"<cr>

" save file
nnoremap <leader>s :only \|:w<cr>

" write and close buffer
nnoremap <leader>w :only \| up \| bd!<cr>

" open file finder
nnoremap <SPACE> :up \| :FZF<cr>

" toggle comments
nnoremap <leader>cc :NERDComToggleComment<cr>

" delete current file
nnoremap <leader>dd :call delete(expand('%')) \| bdelete!<cr>

" rename file
nnoremap <expr> <leader>r ":Rename " . expand('%:t')

" generate ctags for repo
nnoremap <leader>T :!ctags -R .<cr>

" go to definition
nnoremap <leader><tab> <C-]>

" buffer navigation
nnoremap <tab> :only\|up\|bn<cr>
nnoremap <S-tab> :only\|up\|bp<cr>

" open file text replace
nnoremap <Down> :%s /

" copy to system clipboard
vnoremap <cr> "+y<cr>

" paste from system clipboard
vnoremap <BS> "+p<cr>

" spelling
nnoremap <Left> [s
nnoremap <Right> ]s
nnoremap <BS> 1z=

" exit insert mode
inoremap kj <esc>
inoremap jk <esc>
inoremap kk <esc>
inoremap jj <esc>

" align
nnoremap <leader>a :exe "normal ylglip\<c-r>\""<cr>

" completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
