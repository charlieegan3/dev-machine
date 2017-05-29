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
if [[ $(uname) == "Linux" ]]; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi

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
[[ -e $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[[ -e $HOME/.cargo/env ]]       && source $HOME/.cargo/env
[[ -e /usr/local/heroku/bin ]]  && export PATH="/usr/local/heroku/bin:$PATH"

# welcome commander
echo "hello."

# Add language specific settings
export PATH="$PATH:$HOME/.rvm/bin"
export GOPATH=$HOME/Code/go
export PATH="$PATH:$GOPATH/bin"
