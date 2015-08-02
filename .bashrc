# set paths
export PATH=/usr/local/bin:/usr/local/sbin/:/usr/bin:/usr/sbin:/bin:/sbin

# set prompt format
export PS1="\W|"

# use vim as the system editor
export VISUAL=vim
export EDITOR="$VISUAL"

# aliases
alias vi="vim"
alias ls="ls -GF"
alias gits="git status -sb"
alias gitd="git diff -U0 | grep \"^\W\w\""

# rvm config
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# added by travis gem
[ -f /Users/charlieegan3/.travis/travis.sh ] && source /Users/charlieegan3/.travis/travis.sh

# welcome commander
echo "hello."

#fzf search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
