# set prompt format
export PS1="\W|"

# use vim as the system editor
export VISUAL=vim
export EDITOR="$VISUAL"

# set terminal env
export COLORTERM=truecolor
export TERM=xterm-256color

# use correct window size
shopt -s checkwinsize

# use the current tty as the GPG UI
export GPG_TTY=`tty`

# history
export HISTCONTROL=ignorespace:ignoredups
shopt -s histappend

# aliases & functions
alias vi="nvim"
alias ls="ls -AG"
alias dc="docker-compose"
if [[ $(uname) == "Linux" ]]; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
  open() {
    nautilus "$1" &> /dev/null
  }
fi
function gitb() {
  git branch | grep '^\*' | cut -d' ' -f2 | tr -d '\n'
}
function gitpb() {
  gitb | xclip -selection clipboard
}
function source_local_env_file() {
  local_env_file=./local_env.sh
  if [ -e $local_env_file ]; then
    source $local_env_file
    cat $local_env_file
  fi
}
function local_env_cd() {
  builtin cd $1
  source_local_env_file
}
alias cd="local_env_cd"

# tools
[[ -e /usr/local/heroku/bin ]]  && export PATH="/usr/local/heroku/bin:$PATH"
[[ -e $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[[ -e $HOME/.cargo/env ]]       && source $HOME/.cargo/env
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$GOPATH/bin"
export GOPATH=$HOME/Code/go
export PATH=~/.local/bin:$PATH # awscli

# welcome commander
clear
echo "hello."
source_local_env_file
