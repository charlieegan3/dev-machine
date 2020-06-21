# use vim as the system editor
export VISUAL=vim
export EDITOR="$VISUAL"
alias vi='vim'

# set terminal colors
export COLORTERM=truecolor TERM=xterm-256color

# use correct window size
shopt -s checkwinsize

# aliases & functions
alias env='env | sort'
alias ls='ls --color=always --file-type'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias gitb="git branch | grep '^\*' | cut -d' ' -f2 | tr -d '\n'"
alias temp="vim \$(mktemp)"

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
  local ns=$(kubectl get ns --output=custom-columns=name:.metadata.name --no-headers=true | fzf)
  kubens $ns && echo $ns > ~/.kube/namespace
}
kcs() {
  local args=$(gcloud container clusters list "--format=get(name, location)" | awk '{ print $1 " --region=" $2 }' | fzf)
  gcloud container clusters get-credentials $args
  echo "" > ~/.kube/namespace
}
gcs() {
  gcloud config configurations activate $(gcloud config configurations list "--format=get(name)" | fzf)
}
gcr() {
  local args=$(gcloud container clusters list "--format=get(name, location)" | awk '{ print $1 " --region=" $2 }' | fzf)
  gcloud container clusters resize $args --size=$1
}
heic_jpg() {
  for f in *.heic; do heif-convert $f $f.jpg; done
}
namespace_string() {
  local cur_ns=$(cat ~/.kube/namespace)
  if [ "${cur_ns}" != "" ] && [ "${cur_ns}" != "default" ]; then
    echo -n "[$cur_ns]"
  fi
}
last_status_string() {
  last_exit="$?"
  if [ "$last_exit" != "0" ]; then echo -n "[$last_exit]"; fi
}
relative_path_to_git_root() {
  path1=$(git root) path2=$(pwd)
  common=$(printf '%s\x0%s' "${path1}" "${path2}" | sed 's/\(.*\).*\x0\1.*/\1/')
  relative_path="${path2/$common/}"
  if  [ $path1 == "$HOME" ]; then
    echo -n "${PWD##*/}";
  elif [ "${#relative_path}" == "0" ]; then
    echo -n "${PWD##*/}";
  else
    if [ ${#relative_path} -ge 20 ]; then
      relative_path="...$(echo $relative_path | rev | cut -c 1-20 | rev)"
    fi
    echo -n "$relative_path";
  fi
}
bran() {
  echo "Current: " $(gitb)
  git checkout $(git b | sed -e 's/^..//' | fzf)
}
permissions() {
  sudo find . -type d -exec chmod 0755 {} \;
  sudo find . -type f -exec chmod 0644 {} \;
  sudo find . -type f -iname "*.sh" -exec chmod +x {} \;
}
morning() {
  new_date="$(ruby -e "require 'time'; secs = ((Time.now.hour.to_f / 24) * 120 * 60).to_i;   puts (Time.parse(Time.now.strftime('%Y-%m-%d') + ' 07:00:00 +0100') + secs).strftime('%a %d %b %Y 07:19:43 %Z');")"
  GIT_COMMITTER_DATE=$new_date git commit --date "$new_date"
}
envrc() {
	sudo cat .envrc
	sudo chattr -i .envrc
	vi .envrc
	direnv allow
	sudo chattr +i .envrc
}
gitcd() {
	cd $(git rev-parse --show-toplevel)
}
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# Environments
[[ -e $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[[ -e $HOME/.cargo/env ]]       && source $HOME/.cargo/env
export GOROOT="/usr/local/go"
export GOPATH="$HOME/Code/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PATH:$GOROOT/bin"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.npm-packages/bin"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$PATH:$HOME/.tfenv/bin"
export PATH="$PATH:$HOME/.local/bin" # python
export PATH="${PATH}:${KREW_ROOT:-$HOME/.krew}/bin"

# Tools
eval "$(direnv hook bash)"
eval "$(fasd --init auto)"
source "$HOME/google-cloud-sdk/path.bash.inc"
source "$HOME/google-cloud-sdk/completion.bash.inc"
source <(kubectl completion bash)

# History
export HISTSIZE=1000000
export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=100000
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
shopt -s histappend
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
alias exit="history -a; exit"

# GPG
export GPG_TTY=`tty`
export GPG_AGENT_INFO

# set prompt
COLOR_RESET="\[$(tput sgr0)\]" COLOR_CYAN="\[$(tput setaf 6)\]" COLOR_GREEN="\[$(tput setaf 2)\]" COLOR_YELLOW="\[$(tput setaf 3)\]"
export PS1="$COLOR_YELLOW\$(last_status_string)$COLOR_GREEN\$(namespace_string)$COLOR_CYAN\$(relative_path_to_git_root)$COLOR_RESET $ "

# welcome
echo "hello."
