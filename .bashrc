# set prompt format
export PS1="\W|"

# use vim as the system editor
export VISUAL=vim
export EDITOR="$VISUAL"

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
gitb() {
  git branch | grep '^\*' | cut -d' ' -f2 | tr -d '\n'
}
gitpb() {
  gitb | xclip -selection clipboard
}

# tools
[[ -e /usr/local/heroku/bin ]]  && export PATH="/usr/local/heroku/bin:$PATH"
[[ -e $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[[ -e $HOME/.cargo/env ]]       && source $HOME/.cargo/env
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$GOPATH/bin"
export GOPATH=$HOME/Code/go

# welcome commander
echo "hello."
