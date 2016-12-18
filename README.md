# Linux Environment Setup

```
curl https://codeload.github.com/charlieegan3/dotfiles/zip/linux > dotfiles.zip
unzip -jo dotfiles.zip
rm dotfiles.zip
```

* Fetch ssh keys; chmod 400 private key
* Export and import gpg keys
* Install vim; alias vi

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall!
mkdir ~/.vim/colors
curl https://raw.githubusercontent.com/nelstrom/vim-mac-classic-theme/master/colors/mac_classic.vim > ~/.vim/colors/mac_classic.vim
```

* Install git
* `sudo yum install the_silver_searcher`
* Install tree

```
git init .
git remote add -t \* -f origin git@github.com:charlieegan3/dotfiles.git
git fetch origin
git reset --hard origin/linux 
```

* Create a code directory
