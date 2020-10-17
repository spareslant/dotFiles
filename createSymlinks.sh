#! /bin/bash

# This script is going to create symlinks from files in this directory to their respective system locations

THIS_SCRIPT_LOCATION=$(cd $(dirname $0) && pwd)

ln -svf $THIS_SCRIPT_LOCATION/vim/vimrc ~/.vimrc
ln -svf $THIS_SCRIPT_LOCATION/tmux/tmux.conf ~/.tmux.conf
ln -svf $THIS_SCRIPT_LOCATION/zsh/zshrc ~/.zshrc
