autocmd BufRead,BufNewFile *.tf.template set ft=terraform
autocmd BufRead,BufNewFile *.hcl setlocal filetype=terraform
autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,*.ru,*.rake,*.json.jbuilder,*.rb.no} set ft=ruby
autocmd BufRead,BufNewFile {.vim_config} set ft=vim
autocmd BufRead,BufNewFile {*.conf} set ft=c
autocmd BufRead,BufNewFile {*Dockerfile*} set ft=dockerfile
autocmd BufRead,BufNewFile {*Jenkinsfile*} set ft=jenkins
