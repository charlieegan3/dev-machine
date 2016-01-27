# set paths
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
export PATH=/usr/local/texlive/2015/bin/x86_64-darwin:$PATH

export GOPATH=$HOME/Code/Go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# set prompt format
export PS1="\W|"

# use vim as the system editor
export VISUAL=vim
export EDITOR="$VISUAL"

# ignore dupes in history
export HISTIGNORE="&"

# Who knew ^R was a thing?
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

# aliases
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias vi="vim"
alias ls="ls -A --color"
alias l="ls -d */ || echo \"No Directories\" && ls -d .*/ --color && ls -pa | grep -v /"
alias gits="git status -sb"
alias gitb="git branch | grep '^\*' | cut -d' ' -f2 | tr -d '\n' | pbcopy"
alias gitc="git diff --cached --word-diff"
eval "$(hub alias -s)"

alias dc="docker-compose"
alias dm="docker-machine"
alias d="docker"

#fzf search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# other settings
shopt -s histappend
shopt -s checkwinsize

# welcome commander
echo "hello."
