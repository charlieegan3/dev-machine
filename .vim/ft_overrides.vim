autocmd BufRead,BufNewFile *.hcl setlocal filetype=terraform
autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,*.ru,*.rake,*.json.jbuilder} set ft=ruby
autocmd BufRead,BufNewFile {.vim_config} set ft=vim
autocmd BufRead,BufNewFile {*.conf} set ft=c
