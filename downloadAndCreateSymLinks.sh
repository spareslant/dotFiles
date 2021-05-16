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
          git reset --hard
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
    https://github.com/jiangmiao/auto-pairs.git
    https://github.com/chrisbra/unicode.vim.git
    https://github.com/junegunn/fzf.vim.git
    https://github.com/tpope/vim-fugitive.git
    https://github.com/jesseleite/vim-agriculture.git
    https://github.com/morhetz/gruvbox.git
    https://github.com/gcmt/taboo.vim.git
    https://github.com/SirVer/ultisnips.git
    https://github.com/honza/vim-snippets.git
    https://github.com/nanotech/jellybeans.vim.git
    https://github.com/lifepillar/vim-gruvbox8.git
    https://github.com/neoclide/coc.nvim.git
    https://github.com/airblade/vim-gitgutter.git
    https://github.com/vim-airline/vim-airline-themes.git
    https://github.com/voldikss/vim-floaterm.git
    https://github.com/mcchrish/nnn.vim.git
    https://github.com/Yggdroot/indentLine.git
  )
  mkdir -p ~/.vim/pack/plugins/start
  mkdir -p $THIS_SCRIPT_LOCATION/downloaded/vim-plugins
  _updateOrCloneGitRepo "${THIS_SCRIPT_LOCATION}/downloaded/vim-plugins" "${plugins[@]}"
  echo "INFO: Creating vimrc and vim plugin links..."
  ln -svf $THIS_SCRIPT_LOCATION/downloaded/vim-plugins/* ~/.vim/pack/plugins/start
  ln -svf $THIS_SCRIPT_LOCATION/vim/vimrc ~/.vimrc
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
  ln -svf $THIS_SCRIPT_LOCATION/zsh/zshrc ~/.zshrc
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

function downloadExtraShellUtilities() {
  echo "INFO: downloading extra shell utilities..."
  local plugins=(
    "https://github.com/bigH/git-fuzzy.git"
    "https://github.com/jarun/nnn.git"
  )
  mkdir -p "${THIS_SCRIPT_LOCATION}/downloaded/extraShellUtilities"
  _updateOrCloneGitRepo "${THIS_SCRIPT_LOCATION}/downloaded/extraShellUtilities" "${plugins[@]}"
}

function compileNNNandInstall() {
  pushd "${THIS_SCRIPT_LOCATION}/downloaded/extraShellUtilities/nnn"
    echo "INFO: Patching nnn.c to use diamond indicator in detail mode..."
    sed -i -e 's/ACS_CKBOARD/ACS_DIAMOND/g' src/nnn.c
    make clean
    make O_PCRE=1 O_NERD=1 O_CKBOARD=1
    cp -v -f nnn /usr/local/bin/
    make clean
  popd
  rm -rf "${THIS_SCRIPT_LOCATION}/downloaded/extraShellUtilities/nnn"
  curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
  echo "INFO: installing custom nnn plugin..."
  ln -svf $THIS_SCRIPT_LOCATION/nnn/fz-preview-open $HOME/.config/nnn/plugins/
  ln -svf $THIS_SCRIPT_LOCATION/nnn/fz-preview-cd $HOME/.config/nnn/plugins/
}

function createLinks() {
  ln -svf $THIS_SCRIPT_LOCATION/tmux/tmux.conf ~/.tmux.conf
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
downloadExtraShellUtilities
downloadVimPlugins
compileNNNandInstall
createLinks
patchNetrwPlugin
