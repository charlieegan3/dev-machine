# set prompt format
export PS1="\W|"

# use vim as the system editor
export VISUAL=vim
export EDITOR="$VISUAL"
alias vi='vim'
# set -o vi

# set terminal colors
export COLORTERM=truecolor
export TERM=xterm-256color

# use correct window size
shopt -s checkwinsize

# history
export HISTSIZE=1000000
export HISTCONTROL=ignorespace:ignoredups
shopt -s histappend

# aliases & functions
alias env='env | sort'
alias gitb="git branch | grep '^\*' | cut -d' ' -f2 | tr -d '\n'"
alias ron='redshift -O 2000 -m randr'
alias roff='redshift -x -m randr'
alias serve='firefox http://localhost:8000 && ruby -run -ehttpd . -p8000'

if [[ $(uname) == "Linux" ]]; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
  alias ls='ls -ABht --color=always --file-type'
  open() {
    nautilus "$1" &> /dev/null
  }
elif [[ $(uname) == "Darwin" ]]; then
  alias ls='ls -AGt'
fi

# tools
#[[ -e /usr/bin/heroku ]]  && export PATH="$PATH:/usr/bin/heroku"
[[ -e $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[[ -e $HOME/.cargo/env ]]       && source $HOME/.cargo/env
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export GOPATH=$HOME/Code/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.npm-packages/bin"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$PATH:$HOME/.tfenv/bin"
export GPG_TTY=`tty`
eval "$(direnv hook bash)"

gpg-agent --daemon
export GPG_TTY=`tty`
export GPG_AGENT_INFO

source ~/vault_env.sh || true

# welcome
clear
echo "hello."
