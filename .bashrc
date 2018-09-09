# use vim as the system editor
export VISUAL=vim
export EDITOR="$VISUAL"
alias vi='vim'

# set terminal colors
export COLORTERM=truecolor TERM=xterm-256color

# use correct window size
shopt -s checkwinsize

# history
export HISTSIZE=1000000 HISTCONTROL=ignorespace:ignoredups
shopt -s histappend

# aliases & functions
alias env='env | sort'
alias ls='ls --color=always --file-type'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias gitb="git branch | grep '^\*' | cut -d' ' -f2 | tr -d '\n'"

open() {
  xdg-open "$1"
}
replace_in_folder() {
  find $PWD -type f -not -iwholename '*.git*' -exec sed -i "s/$1/$2/g" {} \;
}
serve() {
  firefox http://localhost:8000 && ruby -run -ehttpd "$1" -p8000
}
j() {
  cd $(fasd -dlR | grep $1 | head -n 1) && pwd
}
jj() {
  cd $(fasd -dlR | fzf) && pwd
}
kns() {
  kubens $1 && echo $1 > ~/.kube/namespace
}
namespace_string() {
  txtgrn='\e[0;32m' txtrst='\e[0m'
  cur_ns=$(cat ~/.kube/namespace)
  if [ "${cur_ns}" != "" ] && [ "${cur_ns}" != "default" ]; then
    echo -en "$txtgrn$cur_ns$txtrst "
  fi
}
last_status_string() {
  last_exit="$?" txtylw='\e[0;33m' txtrst='\e[0m'
  if [ "$last_exit" != "0" ]; then echo -en "$txtylw$last_exit$txtrst "; fi
}

# Environments
[[ -e $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[[ -e $HOME/.cargo/env ]]       && source $HOME/.cargo/env
export GOPATH=$HOME/Code/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.npm-packages/bin"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$PATH:$HOME/.tfenv/bin"

# Tools
eval "$(direnv hook bash)"
eval "$(fasd --init auto)"
source ~/vault_env.sh || true
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# GPG
export GPG_TTY=`tty`
export GPG_AGENT_INFO

# Completion Scripts
source '/home/charlieegan3/google-cloud-sdk/completion.bash.inc'
source <(kubectl completion bash)

# set prompt
export PS1="\$(last_status_string)\$(namespace_string)\W $ "

# welcome
clear
echo "hello."
