# set prompt format
export PS1="\W|"

# use vim as the system editor
export VISUAL=vim
export EDITOR="$VISUAL"
alias vi='vim'
set -o vi

# set terminal colors
export COLORTERM=truecolor
export TERM=xterm-256color

# use correct window size
shopt -s checkwinsize

# history
export HISTCONTROL=ignorespace:ignoredups
shopt -s histappend

# aliases & functions
alias ls='ls -ABht --color=always --file-type'
alias env='env | sort'
alias gitb="git branch | grep '^\*' | cut -d' ' -f2 | tr -d '\n'"

if [[ $(uname) == "Linux" ]]; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
  open() {
    nautilus "$1" &> /dev/null
  }
fi

# tools
[[ -e /usr/local/heroku/bin ]]  && export PATH="/usr/local/heroku/bin:$PATH"
[[ -e $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[[ -e $HOME/.cargo/env ]]       && source $HOME/.cargo/env
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$GOPATH/bin"
export GOPATH=$HOME/Code/go
export PATH=~/.local/bin:$PATH # awscli
export GPG_TTY=`tty`
eval "$(direnv hook bash)"

# welcome
clear
echo "hello."
