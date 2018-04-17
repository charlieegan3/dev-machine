set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

nnoremap tt :! clear; bundle exec rspec % \| grep -v '/gems/'<cr>
