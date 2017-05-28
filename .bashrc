# set prompt format
export PS1="\W|"

# use vim as the system editor
export VISUAL=vim
export EDITOR="$VISUAL"

# use the current tty as the GPG UI
export GPG_TTY=`tty`

# history
HISTCONTROL=ignorespace:ignoredups

# aliases
alias vi="nvim"
alias ls="ls -AG"

alias dc="docker-compose"
alias dk='docker stop $(docker ps -a -q)'

alias xcopy="xclip -o | xclip -selection clipboard"

# functions
gitb() {
  git branch | grep '^\*' | cut -d' ' -f2 | tr -d '\n'
}
gitpb() {
  gitb | xclip -selection clipboard
}

#fzf search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# other settings
shopt -s histappend
shopt -s checkwinsize

# toolchains
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[[ -s $HOME/.cargo/env ]]       && source $HOME/.cargo/env
[[ -s /usr/local/heroku/bin ]]  && export PATH="/usr/local/heroku/bin:$PATH"

# welcome commander
echo "hello."

# Add language specific settings
export PATH="$PATH:$HOME/.rvm/bin"
export GOPATH=$HOME/Code/go
export PATH="$PATH:$GOPATH/bin"
