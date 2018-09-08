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

if [[ $(uname) == "Linux" ]]; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
  alias ls='ls --color=always --file-type'
  open() {
    nautilus "$1" &> /dev/null
  }
  replace_in_folder() {
    find $PWD -type f -not -iwholename '*.git*' -exec sed -i "s/$1/$2/g" {} \;
  }
elif [[ $(uname) == "Darwin" ]]; then
  alias ls='ls -AGt'
fi

serve() {
	firefox http://localhost:8000
	ruby -run -ehttpd "$1" -p8000
}

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

gpg-agent --daemon || true
export GPG_TTY=`tty`
export GPG_AGENT_INFO

source ~/vault_env.sh || true

eval "$(fasd --init auto)"
j() {
  cd $(fasd -dlR | grep $1 | head -n 1)
  pwd
}
jj() {
  cd $(fasd -dlR | fzf)
  pwd
}

# kubectx
current_namespace() {
  local cur_ctx
  cur_ctx="$(current_context)"
  ns="$(kubectl config view -o=jsonpath="{.contexts[?(@.name==\"${cur_ctx}\")].context.namespace}")"
  if [[ -z "${ns}" ]]; then
    echo "default"
  else
    if [ "${ns}" != "default" ]; then
      echo "${ns}"
    fi
  fi
}
current_context() {
  kubectl config view -o=jsonpath='{.current-context}'
}
namespace_string() {
  txtgrn='\e[0;32m'
  txtrst='\e[0m'
  cur_ns="$(current_namespace)"
  if [ "${cur_ns}" != "" ]; then
    echo -en "$txtgrn$cur_ns$txtrst "
  fi
}
last_status_string() {
  last_exit="$?"

  txtylw='\e[0;33m'
  txtrst='\e[0m'

  if [ "$last_exit" != "0" ]; then
    echo -en "$txtylw$last_exit$txtrst "
  fi
}

export PS1="\$(last_status_string)\$(namespace_string)\W $ "

# Completion Scripts
source '/home/charlieegan3/google-cloud-sdk/completion.bash.inc'
source <(kubectl completion bash)

# welcome
clear
echo "hello."

