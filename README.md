#dotfiles

Config files for bash, vim, git and iTerm. `bootstrap.sh` is a script for setting up a fresh machine. Inspired by [this](http://spin.atomicobject.com/2015/09/21/ansible-configuration-management-laptop/), based on [this](http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac) and [this](https://github.com/hjuutilainen/dotfiles/blob/master/bin/osx-user-defaults.sh). The script sets defaults for OS X, sets up this repo, installs binaries and apps with homebrew, configures vim and ssh, sets login items and reminds me of a few things.

```
curl https://raw.githubusercontent.com/charlieegan3/dotfiles/master/bootstrap.sh > bootstrap.sh 
bash bootstrap.sh
```
