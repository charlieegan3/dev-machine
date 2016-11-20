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
alias dc="docker-compose"
alias dk='docker stop $(docker ps -a -q)'

# functions
docker-clean() {
  docker rm $(docker ps -a -q)
  docker rmi $(docker images -a | grep "^<none>" | awk '{print $3}')
}
gitb() {
  git branch | grep '^\*' | cut -d' ' -f2 | tr -d '\n'
}
gitpb() {
  gitb | pbcopy
}
gitpub() {
  git push origin $(gitb)
}
dvim() {
  # docker build -f ~/Dockerfile -t charlieegan3/vim ~ > /dev/null
  docker run --rm -it -v "$(pwd):/project" -w /project charlieegan3/vim vim $@
}

#fzf search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

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
