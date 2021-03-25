#! /bin/bash

set -euo pipefail

# This script is going to create symlinks from files in this directory to their respective system locations
# Works with VIM that supports native plugin manager. (use VIM 8.0+)
# This script is idempotent

THIS_SCRIPT_LOCATION=$(cd $(dirname $0) && pwd)
mkdir -p $THIS_SCRIPT_LOCATION/downloaded

function setupCommonSwapDir() {
  mkdir -p $HOME/.vim/swapfiles/
}

function _updateOrCloneGitRepo() {
  local path="$1"
  shift
  local urls=("$@")
  pushd "${path}"
    for url in "${urls[@]}"
    do
      local dirName=$(echo $url | perl -wnl -e 'm!.+/(.+)\.git! and print "$1"')
      if [[ -d ${dirName} ]]
      then
        pushd ${path}/${dirName}
          git pull -r
        popd || exit 1
      else
        git clone ${url}
      fi
    done
  popd

}

function downloadVimPlugins() {
  echo "INFO: Downloading plugins...."
  local plugins=(
    https://github.com/vim-airline/vim-airline.git
    https://github.com/danilo-augusto/vim-afterglow.git
    https://github.com/jiangmiao/auto-pairs.git
    https://github.com/dense-analysis/ale.git
    https://github.com/chrisbra/unicode.vim.git
    https://github.com/junegunn/fzf.vim.git
    https://github.com/tpope/vim-fugitive.git
    https://github.com/jesseleite/vim-agriculture.git
    https://github.com/morhetz/gruvbox.git
    https://github.com/gcmt/taboo.vim.git
    https://github.com/SirVer/ultisnips.git
    https://github.com/honza/vim-snippets.git
    https://github.com/nanotech/jellybeans.vim.git
  )
  mkdir -p ~/.vim/pack/plugins/start
  mkdir -p $THIS_SCRIPT_LOCATION/downloaded/vim-plugins
  _updateOrCloneGitRepo "${THIS_SCRIPT_LOCATION}/downloaded/vim-plugins" "${plugins[@]}"
}

function installPowerlineFonts() {
  echo "INFO: Installing powerline fonts....."
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
  local plugin="https://github.com/ohmyzsh/ohmyzsh.git"
  local zshUrls=(
    "https://github.com/ohmyzsh/ohmyzsh.git"
  )
  _updateOrCloneGitRepo "$THIS_SCRIPT_LOCATION/downloaded" "${zshUrls[@]}"
  if [[ ! -L "${HOME}/.oh-my-zsh" ]]
  then
    local backupName="oh-my-zsh.backup.$(date +%Y-%m-%d-%H:%M:%S)"
    echo "WARNING: Found ${HOME}/.oh-my-zsh, backing it up as ${backupName}..."
    mv "${HOME}/.oh-my-zsh" "${HOME}/${backupName}"
  fi
  ln -svf $THIS_SCRIPT_LOCATION/downloaded/ohmyzsh ~/.oh-my-zsh
}

function installZshPlugins() {
  echo "INFO: downloading zsh plugins..."
  local plugins=(
    "https://github.com/zsh-users/zsh-autosuggestions.git"
    "https://github.com/zsh-users/zsh-syntax-highlighting.git"
    "https://github.com/zsh-users/zsh-completions.git"
    "https://github.com/zsh-users/zsh-history-substring-search.git"
  )
  _updateOrCloneGitRepo "${THIS_SCRIPT_LOCATION}/downloaded/ohmyzsh/custom/plugins" "${plugins[@]}"
}

function setupGitFuzzyForZsh() {
  echo "INFO: downloading extra shell utilities..."
  local plugins=(
    "https://github.com/bigH/git-fuzzy.git"
  )
  mkdir -p "${THIS_SCRIPT_LOCATION}/downloaded/extraShellUtilities"
  _updateOrCloneGitRepo "${THIS_SCRIPT_LOCATION}/downloaded/extraShellUtilities" "${plugins[@]}"
  #echo "export PATH=\"${THIS_SCRIPT_LOCATION}/downloaded/extraShellUtilities/git-fuzzy/bin:\$PATH\"" >> ~/.zshrc
}

function createLinks() {
  ln -svf $THIS_SCRIPT_LOCATION/downloaded/vim-plugins/* ~/.vim/pack/plugins/start
  ln -svf $THIS_SCRIPT_LOCATION/vim/vimrc ~/.vimrc
  ln -svf $THIS_SCRIPT_LOCATION/tmux/tmux.conf ~/.tmux.conf
  ln -svf $THIS_SCRIPT_LOCATION/zsh/zshrc ~/.zshrc
  ln -svf $THIS_SCRIPT_LOCATION/git_configs/gitconfig ~/.gitconfig
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
    echo "INFO: ${vimRunTimePath}/autoload/netrw.vim already pacthed. Skipping this patch.."
  else
    cp -pv "${vimRunTimePath}/autoload/netrw.vim" "${backupFile}"
    cp -vf "${patchedFile}" "${vimRunTimePath}/autoload/netrw.vim"
  fi

}

setupCommonSwapDir
installPowerlineFonts
installZsh
installZshPlugins
setupGitFuzzyForZsh
downloadVimPlugins
createLinks
patchNetrwPlugin
