# set paths
export PATH=/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:$PATH

# set prompt format 
export PS1="\W|"

# use vim as the system editor
export VISUAL=vim
export EDITOR="$VISUAL"

# ls coloring
alias ls="ls -GF"

# rvm config
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# added by travis gem
[ -f /Users/charlieegan3/.travis/travis.sh ] && source /Users/charlieegan3/.travis/travis.sh

# welcome commander
echo "hello."

