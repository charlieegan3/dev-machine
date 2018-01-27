let mapleader=";"

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
