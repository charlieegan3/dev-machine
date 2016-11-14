# set paths
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
export PATH=/usr/local/texlive/2015/bin/x86_64-darwin:$PATH
export PATH=/Users/charlie/.cargo/bin:$PATH

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
alias ls="ls -A --color"
alias gits="git status -sb"
alias gitb="git branch | grep '^\*' | cut -d' ' -f2 | tr -d '\n'"
alias gitpb="gitb | pbcopy"
alias gitpub='git push origin $(gitb)'
alias gitc="git diff --cached --word-diff=color"
alias gitch="git clean -df && git checkout -- ."
alias gitcm="git log -1 --pretty=%B"

alias dc="docker-compose"
alias dk='docker stop $(docker ps -a -q)'

alias kb='kubectl'
alias kbs='kb get pods && kb get deployments && kb get services'

dvim() {
  # docker build -f ~/Dockerfile -t charlieegan3/vim ~ > /dev/null
  docker run --rm -it -v "$(pwd):/project" -w /project charlieegan3/vim vim $@
}

docker-clean() {
  docker rm $(docker ps -a -q)
  docker rmi $(docker images -a | grep "^<none>" | awk '{print $3}')
}

#fzf search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#iterm integration
source ~/.iterm2_shell_integration.bash

# other settings
shopt -s histappend
shopt -s checkwinsize

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# configure Ctrl-w behavior
stty werase undef
bind '\C-w:unix-filename-rubout'

# welcome commander
echo "hello."
