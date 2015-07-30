export PATH=/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:$PATH
export PS1="\W|"
export VISUAL=vim
export EDITOR="$VISUAL"

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# added by travis gem
[ -f /Users/charlieegan3/.travis/travis.sh ] && source /Users/charlieegan3/.travis/travis.sh

echo "hello."

