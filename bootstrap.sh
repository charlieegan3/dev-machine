#----------------------------------------------------------------------------------------------------------------
# OSX
#----------------------------------------------------------------------------------------------------------------
sudo systemsetup -settimezone Europe/London
sudo systemsetup -setrestartfreeze on

# System
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write -g ApplePersistence -bool no

# UI
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.universalaccess reduceTransparency -bool true
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# Dock
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock persistent-apps -array ""
defaults write com.apple.dock persistent-others -array ""
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.3
defaults write com.apple.dock autohide-delay -float 0.5
defaults write com.apple.dock wvous-tr-corner -int 4
killall Dock

# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Tap with two fingers to emulate right click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# Enable three finger tap (look up)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 2

# Enable three finger drag
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Disable Zoom in or out
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadPinch -bool false

# Disable Smart zoom, double-tap with two fingers
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture -bool false

# Disable Rotate
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate -bool false

# Disable Swipe between pages with two fingers
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool false

# Swipe between full-screen apps
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2

# Disable feature gestures
defaults write com.apple.dock showMissionControlGestureEnabled -bool false
defaults write com.apple.dock showAppExposeGestureEnabled -bool false
defaults write com.apple.dock showDesktopGestureEnabled -bool false
defaults write com.apple.dock showLaunchpadGestureEnabled -bool false

# Finder
defaults write com.apple.finder NewWindowTarget PfHm
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Safari
shell "defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2"
shell "defaults write com.apple.Safari IncludeDebugMenu -bool true"
shell 'defaults write com.apple.Safari ProxiesInBookmarksBar "()"'

#TODO Spotlight

#----------------------------------------------------------------------------------------------------------------
# Dotfiles
#----------------------------------------------------------------------------------------------------------------
curl https://codeload.github.com/charlieegan3/dotfiles/zip/master > dotfiles.zip
unzip -jo dotfiles.zip
rm dotfiles.zip
# to get the correct Go env
source .bashrc

#----------------------------------------------------------------------------------------------------------------
# Directories
#----------------------------------------------------------------------------------------------------------------
mkdir Code
mkdir -p Code/Go/src/github.com/charlieegan3

#----------------------------------------------------------------------------------------------------------------
# homebrew
#----------------------------------------------------------------------------------------------------------------
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew tap homebrew/bundle
brew bundle
brew upgrade `brew outdated`
brew cleanup
brew cask cleanup

#----------------------------------------------------------------------------------------------------------------
# vim
#----------------------------------------------------------------------------------------------------------------
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall!
vim +GoInstallBinaries +qall!

#----------------------------------------------------------------------------------------------------------------
# ssh
#----------------------------------------------------------------------------------------------------------------
file="/Users/charlieegan3/.ssh/id_rsa"
if ! [ -f "$file" ]; then
	echo "$file not found."
	ssh-keygen -t rsa -b 4096 -C "git@charlieegan3.com"
  ssh-add ~/.ssh/id_rsa
  pbcopy < ~/.ssh/id_rsa.pub
  open https://github.com/settings/ssh
  read -p "GitHub all up to date?"
fi

#----------------------------------------------------------------------------------------------------------------
# Link Dotfiles
#----------------------------------------------------------------------------------------------------------------
git init .
git remote add -t \* -f origin git@github.com:charlieegan3/dotfiles.git
git fetch origin
git reset --hard origin/master

#----------------------------------------------------------------------------------------------------------------
# Set Login Items
#----------------------------------------------------------------------------------------------------------------
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Dropbox.app", hidden:true}'
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Flux.app", hidden:true}'
osascript -e 'tell application "System Events" to get the name of every login item'

#----------------------------------------------------------------------------------------------------------------
# Finishing Touches
#----------------------------------------------------------------------------------------------------------------
open -a "Google Chrome" --args --make-default-browser
echo "set completion-ignore-case On" >> ~/.inputrc
go get github.com/tools/godep

#----------------------------------------------------------------------------------------------------------------
# TODO
#----------------------------------------------------------------------------------------------------------------
curl http://assets.undercoverhq.com/client/6.5/undercover_mac.pkg > ~/Desktop/undercover.pkg
open /Applications/App\ Store.app/
open /Applications/System\ Preferences.app/
open /Applications/Google\ Chrome.app
echo "TODO: Setings"
echo " - Spotlight"
echo " - iTerm PrefsCustomFolder"
echo " - Google and Twitter Accounts"
echo " - Disable iCloud in Contacts app preferences"
echo " - Dropbox setup, Day One and 1Password Sync"
echo " - Chrome Login, set downloads folder, 1Password add on"

echo "TODO: Install"
echo " - Little Snitch Installer"
echo " - Under Cover Installer"
echo " - Garmin Connect"
echo " - Mac App Store (PDF Expert, Day One, Better Snap Tool, Fantastical, Wifi Explorer, Pixelmator)"

read -p "Press enter to restart"
sudo shutdown -r now
