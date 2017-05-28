sudo apt-get update
sudo apt-get install git

git init .
git remote add -t \* -f origin https://github.com/charlieegan3/dotfiles.git
git fetch origin
git reset --hard origin/master

sudo apt-get install firefox urxvt tree the_silver_searcher vim 

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall!

sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi

mkdir ~/Code
