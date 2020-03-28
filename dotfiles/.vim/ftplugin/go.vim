let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_doc_keywordprg_enabled = "0"
let g:go_metalinter_autosave = 1
" let g:go_metalinter_command = "--enable=gotype --enable=vet --enable=golint -t"
" let g:go_metalinter_autosave_enabled = [ 'golint', 'gotype', 'vet' ]
let g:go_metalinter_command = "--enable=vet --enable=golint -t"
let g:go_metalinter_autosave_enabled = [ 'golint', 'vet' ]

highlight Type        ctermfg=220
highlight Statement   ctermfg=197
highlight Keyword     ctermfg=33
highlight Conditional ctermfg=33
highlight Label       ctermfg=33
highlight Repeat      ctermfg=33
highlight Number      ctermfg=28
highlight Integer     ctermfg=28
highlight String      ctermfg=28
highlight Operator    ctermfg=196
highlight Function    ctermfg=166
highlight Identifier  ctermfg=70

let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1

setlocal nolist
setlocal syntax=on
setlocal noexpandtab tabstop=4 softtabstop=4
nnoremap tt :! clear; go test<cr>
nnoremap tr :GoAlternate<cr>
nnoremap <tab> :GoDef<cr>
nnoremap <leader>g :GoDeclsDir<cr>
nnoremap <leader>d :GoDoc<cr>
nnoremap <leader>i :GoInfo<cr>
nnoremap <leader>e :GoIfErr<cr>

set nospell
