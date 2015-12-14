# set paths
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
export PATH=/usr/local/texlive/2015/bin/x86_64-darwin:$PATH

# set prompt format
export PS1="\W|"

# use vim as the system editor
export VISUAL=vim
export EDITOR="$VISUAL"

# aliases
alias vi="vim"
alias ls="ls -A --color"
alias l="ls -d */ --color && ls -pa | grep -v /"
alias gits="git status -sb"
alias gitd="git diff -U0 | grep \"^\W\w\""
alias gitb="git branch | grep '^\*' | cut -d' ' -f2 | tr -d '\n' | pbcopy"

# welcome commander
echo "hello."

#fzf search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
