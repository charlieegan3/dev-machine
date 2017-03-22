# set prompt format
export PS1="\W|"

# use vim as the system editor
export VISUAL=vim
export EDITOR="$VISUAL"

# use the current tty as the GPG UI
export GPG_TTY=`tty`

# history
HISTCONTROL=ignorespace:ignoredups
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

# aliases
alias vi="vim"
alias ls="ls -AG"

alias dc="docker-compose"
alias dk='docker stop $(docker ps -a -q)'

alias xcopy="xclip -o | xclip -selection clipboard"

# functions
docker-clean() {
  docker rm $(docker ps -a -q)
  docker rmi $(docker images -a | grep "^<none>" | awk '{print $3}')
}
gitb() {
  git branch | grep '^\*' | cut -d' ' -f2 | tr -d '\n'
}
gitpb() {
  gitb | xclip -selection clipboard
}
gitpub() {
  git push origin $(gitb)
}
vpn-init() {
  sudo expect /etc/openvpn/start.sh
}
vpn-exit() {
  sudo killall openvpn
}

#fzf search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# other settings
shopt -s histappend
shopt -s checkwinsize

# configure Ctrl-w behavior
stty werase undef
bind '\C-w:unix-filename-rubout'

source $HOME/.rvm/scripts/rvm
source $HOME/.cargo/env

# welcome commander
echo "hello."
