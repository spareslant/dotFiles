#! /bin/bash

# This script is going to create symlinks from files in this directory to their respective system locations
# Works with VIM that supports native plugin manager. (use VIM 8.0+)

THIS_SCRIPT_LOCATION=$(cd $(dirname $0) && pwd)

mkdir -p ~/.vim/pack/plugins/start

function downloadPlugins() {
  pushd $THIS_SCRIPT_LOCATION
    mkdir -p downloadedPlugins
    pushd $THIS_SCRIPT_LOCATION/downloadedPlugins
      git clone https://github.com/vim-airline/vim-airline.git
      git clone https://github.com/danilo-augusto/vim-afterglow.git
      git clone https://github.com/jiangmiao/auto-pairs.git
      git clone https://github.com/dense-analysis/ale.git
    popd || exit
  popd || exit
}

function installPowerlineFonts() {
  echo "Installing powerline fonts....."
  # there is uninstall script as well in the repository.
  mkdir -p $THIS_SCRIPT_LOCATION/powerlineFonts
  pushd $THIS_SCRIPT_LOCATION/powerlineFonts
    git clone https://github.com/powerline/fonts.git --depth=1
    pushd fonts
    ./install.sh
    popd || exit
  popd || exit
}

function installZsh() {
  git clone https://github.com/ohmyzsh/ohmyzsh.git
  ln -svf $THIS_SCRIPT_LOCATION/ohmyzsh ~/.oh-my-zsh

}

function createLinks() {
  ln -svf $THIS_SCRIPT_LOCATION/downloadedPlugins/* ~/.vim/pack/plugins/start
  ln -svf $THIS_SCRIPT_LOCATION/vim/vimrc ~/.vimrc
  ln -svf $THIS_SCRIPT_LOCATION/tmux/tmux.conf ~/.tmux.conf
  ln -svf $THIS_SCRIPT_LOCATION/zsh/zshrc ~/.zshrc
}

installPowerlineFonts
installZsh
downloadedPlugins
createLinks
