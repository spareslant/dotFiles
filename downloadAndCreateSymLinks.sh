#! /bin/bash

set -euo pipefail

# This script is going to create symlinks from files in this directory to their respective system locations
# Works with VIM that supports native plugin manager. (use VIM 8.0+)
# This script is idempotent

THIS_SCRIPT_LOCATION=$(cd $(dirname $0) && pwd)
mkdir -p $THIS_SCRIPT_LOCATION/downloaded

function downloadPlugins() {
  plugins=(
    https://github.com/vim-airline/vim-airline.git
    https://github.com/danilo-augusto/vim-afterglow.git
    https://github.com/jiangmiao/auto-pairs.git
    https://github.com/dense-analysis/ale.git
    https://github.com/chrisbra/unicode.vim.git
  )
  mkdir -p ~/.vim/pack/plugins/start
  mkdir -p $THIS_SCRIPT_LOCATION/downloaded/vim-plugins
  pushd $THIS_SCRIPT_LOCATION/downloaded/vim-plugins
  for plugin in "${plugins[@]}"
  do
    local dirName=$(echo $plugin | perl -wnl -e 'm!.+/(.+)\.git! and print "$1"')
    if [[ -d ${dirName} ]]
    then
      pushd $THIS_SCRIPT_LOCATION/downloaded/vim-plugins/${dirName}
        git pull -r
      popd || exit 1
    else
      git clone ${plugin}
    fi
  done
  popd || exit 1
}

function installPowerlineFonts() {
  echo "Installing powerline fonts....."
  # there is uninstall script as well in the repository.
  pushd $THIS_SCRIPT_LOCATION/downloaded
    if [[ -d powerLineFonts ]]
    then
      pushd powerLineFonts
        git pull -r
        popd || exit 1
    else
      git clone https://github.com/powerline/fonts.git --depth=1 powerLineFonts
      pushd powerLineFonts
      ./install.sh
    fi
  popd || exit 1
}

function installZsh() {
  pushd $THIS_SCRIPT_LOCATION/downloaded
    local plugin="https://github.com/ohmyzsh/ohmyzsh.git"
    local dirName=$(echo $plugin | perl -wnl -e 'm!.+/(.+)\.git! and print "$1"')
    if [[ -d ${dirName} ]]
    then
      pushd ${dirName}
      git pull -r
    else
      git clone "${plugin}"
    fi
    ln -svf $THIS_SCRIPT_LOCATION/ohmyzsh ~/.oh-my-zsh
  popd

}

function createLinks() {
  ln -svf $THIS_SCRIPT_LOCATION/downloaded/vim-plugins/* ~/.vim/pack/plugins/start
  ln -svf $THIS_SCRIPT_LOCATION/vim/vimrc ~/.vimrc
  ln -svf $THIS_SCRIPT_LOCATION/tmux/tmux.conf ~/.tmux.conf
  ln -svf $THIS_SCRIPT_LOCATION/zsh/zshrc ~/.zshrc
}

function patchNetrwPlugin() {
  echo "patch netrw.vim file for smooth vertical lines "
  vimRunTimePath=$(vim -e -T dumb --cmd 'exe "set t_cm=\<C-M>"|echo $VIMRUNTIME|quit' | tr -d '\015')
  if [[ ! -e "${vimRunTimePath}/autoload/netrw.vim" ]]
  then
    echo "ERROR: could not find ${vimRunTimePath}/autoload/netrw.vim file.."
    exit 2
  fi
  timeStamp="$(date +%Y-%m-%d-%H:%M:%S)"
  backupFile="${vimRunTimePath}/autoload/netrw.vim".backup.${timeStamp}
  patchedFile="/tmp/pacthedFile.${timeStamp}"
  perl -wnl -e 'm!(.*let s:treedepthstring=)! and print "$1 \"│ \"" or print' "${vimRunTimePath}/autoload/netrw.vim" > ${patchedFile}
  if diff -b ${patchedFile} "${vimRunTimePath}/autoload/netrw.vim" > /dev/null 2>&1
  then
    echo "${vimRunTimePath}/autoload/netrw.vim already pacthed. Skipping this patch.."
  else
    cp -pv "${vimRunTimePath}/autoload/netrw.vim" "${backupFile}"
    cp -vf "${patchedFile}" "${vimRunTimePath}/autoload/netrw.vim"
  fi

}

installPowerlineFonts
installZsh
downloadPlugins
createLinks
patchNetrwPlugin
