#! /bin/bash

set -euo pipefail

# This script is going to create symlinks from files in this directory to their respective system locations
# Works with VIM that supports native plugin manager. (use VIM 8.0+)
# This script is idempotent

THIS_SCRIPT_LOCATION=$(cd $(dirname $0) && pwd)
mkdir -p $THIS_SCRIPT_LOCATION/downloaded
mkdir -p $THIS_SCRIPT_LOCATION/rendered_configs

function setupCommonSwapDir() {
    mkdir -p $HOME/.vim/swapfiles/
}

function backUpandMove() {
  local entity="$1"
    if [[ -e "$entity" && ! -L "$entity" ]]
    then
        local backupName="$entity.backup.$(date +%Y-%m-%d-%H:%M:%S)"
        echo "WARNING: Found $entity, backing it up as ${backupName}..."
        mv "$entity" "$backupName"
    fi

}

function _updateOrCloneGitRepo() {
    local path="$1"
    shift
    local urls=("$@")
    local all_dirs_in_urls=("")
    pushd "${path}"
        for url in "${urls[@]}"
        do
            local dirName=$(echo $url | perl -wnl -e 'm!.+/(.+)\.git! and print "$1"')
            all_dirs_in_urls=(${all_dirs_in_urls[@]} $dirName)
            if [[ -d ${dirName} ]]
            then
                pushd ${path}/${dirName}
                    git reset --hard
                    git pull -r
                popd || exit 1
            else
                git clone --depth 1 ${url}
            fi
        done
    popd

    # remove unwanted vim and zsh plugin repos
    if echo "$path" | egrep -q 'vim-plugins|ohmyzsh/custom/plugins'
    then
        local dirs_in_path=($(/bin/ls -1 ${path}))
        for dir in "${dirs_in_path[@]}"
        do
            local not_found="true"
            for url_dir in "${all_dirs_in_urls[@]}"
            do
                if [[ "$url_dir" == "$dir" ]]
                then
                        not_found="false"
                        break
                fi
            done
            if [[ "$not_found" == "true" ]]  
            then
                echo "WARNING: unwanted plugin ${path}/${dir} will be removed."
                rm -rfv ${path}/${dir} 
                if echo "$path" | egrep -q 'vim-plugins'
                then
                    rm -f ~/.vim/pack/plugins/start/${dir}
                fi
            fi
        done
    fi
}

function downloadVimPlugins() {
    echo "INFO: Downloading plugins...."
    local plugins=(
        https://github.com/vim-airline/vim-airline.git
        https://github.com/jiangmiao/auto-pairs.git
        https://github.com/junegunn/fzf.vim.git
        https://github.com/jesseleite/vim-agriculture.git
        https://github.com/neoclide/coc.nvim.git
        https://github.com/airblade/vim-gitgutter.git
        https://github.com/vim-airline/vim-airline-themes.git
        https://github.com/voldikss/vim-floaterm.git
        https://github.com/mcchrish/nnn.vim.git
        https://github.com/Yggdroot/indentLine.git
        https://github.com/chriskempson/base16-vim.git
        https://github.com/saltstack/salt-vim.git
        https://github.com/stephpy/vim-yaml.git
        https://github.com/lepture/vim-jinja.git
        https://github.com/hashivim/vim-terraform.git
        https://github.com/jamessan/vim-gnupg.git
        https://github.com/psliwka/vim-smoothie.git
    )
    mkdir -p ~/.vim/pack/plugins/start
    mkdir -p $THIS_SCRIPT_LOCATION/downloaded/vim-plugins
    _updateOrCloneGitRepo "${THIS_SCRIPT_LOCATION}/downloaded/vim-plugins" "${plugins[@]}"
    echo "INFO: Creating vimrc and vim plugin links..."
    ln -svf $THIS_SCRIPT_LOCATION/downloaded/vim-plugins/* ~/.vim/pack/plugins/start
    backUpandMove "${HOME}/.vimrc"
    ln -svf $THIS_SCRIPT_LOCATION/vim/vimrc ${HOME}/.vimrc
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
    backUpandMove "${HOME}/.oh-my-zsh"
    backUpandMove "${HOME}/.zshrc"
    backUpandMove "${HOME}/.zprofile"
    ln -svf $THIS_SCRIPT_LOCATION/downloaded/ohmyzsh ${HOME}/.oh-my-zsh
    ln -svf $THIS_SCRIPT_LOCATION/zsh/zshrc ${HOME}/.zshrc
    ln -svf $THIS_SCRIPT_LOCATION/zsh/zprofile ${HOME}/.zprofile
    ln -svf $THIS_SCRIPT_LOCATION/zsh/gpal.zsh-theme $THIS_SCRIPT_LOCATION/downloaded/ohmyzsh/themes/
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
        "https://github.com/mattdavis90/base16-tmux.git"
        "https://github.com/Gogh-Co/Gogh.git"
    )
    mkdir -p "${THIS_SCRIPT_LOCATION}/downloaded/extraShellUtilities"
    _updateOrCloneGitRepo "${THIS_SCRIPT_LOCATION}/downloaded/extraShellUtilities" "${plugins[@]}"
}

function compileNNNandInstall() {
    pushd "${THIS_SCRIPT_LOCATION}/downloaded/extraShellUtilities/nnn"
        echo "INFO: Patching nnn.c to use diamond indicator in detail mode..."
        sed -i -e 's/ACS_CKBOARD/ACS_DIAMOND/g' src/nnn.c
        make clean
        make O_PCRE=1 O_NERD=1 O_CKBOARD=1 O_GITSTATUS=1
        cp -v -f nnn /usr/local/bin/
        make clean
    popd
    rm -rf "${THIS_SCRIPT_LOCATION}/downloaded/extraShellUtilities/nnn"
    echo "Install nnn plugins..."
    rm -rf $HOME/.config/nnn
    curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
    echo "INFO: installing custom nnn plugin..."
    ln -svf $THIS_SCRIPT_LOCATION/nnn/fz-preview-open $HOME/.config/nnn/plugins/
    ln -svf $THIS_SCRIPT_LOCATION/nnn/fz-preview-cd $HOME/.config/nnn/plugins/
}

function createLinks() {
    mkdir -p "${HOME}/.gnupg"
    backUpandMove "${HOME}/.gitconfig"
    backUpandMove "${HOME}/.tmux.conf"
    backUpandMove "${HOME}/.gnupg/gpg-agent.conf"
    ln -svf $THIS_SCRIPT_LOCATION/git_configs/gitconfig ${HOME}/.gitconfig
    ln -svf $THIS_SCRIPT_LOCATION/rendered_configs/tmux.conf ${HOME}/.tmux.conf
    ln -svf $THIS_SCRIPT_LOCATION/gnupg/gpg-agent.conf ${HOME}/.gnupg/gpg-agent.conf
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

function buildVimCocPlugin() {
    pushd "${THIS_SCRIPT_LOCATION}/downloaded/vim-plugins/coc.nvim"
       npm install esbuild
       npm run build
    popd
}

function setupNvim() {
    mkdir -p "${HOME}/.local/share"
    backUpandMove "${HOME}/.local/share/nvim"
    backUpandMove "${HOME}/.config/nvim"
    mkdir -p $THIS_SCRIPT_LOCATION/downloaded/nvim
    echo "INFO: Creating ${HOME}/.config/nvim and ${HOME}/.local/share/nvim plugin links..."
    ln -svf $THIS_SCRIPT_LOCATION/downloaded/nvim ${HOME}/.local/share/
    ln -svf $THIS_SCRIPT_LOCATION/nvim ${HOME}/.config/
    mkdir -p ${HOME}/.local/share/nvim/site/pack/packer/start
    _updateOrCloneGitRepo "${HOME}/.local/share/nvim/site/pack/packer/start" "https://github.com/wbthomason/packer.nvim.git"

    nvim -u $THIS_SCRIPT_LOCATION/nvim/lua/plugins/init.lua  --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

function setupAlacritty() {
    backUpandMove "${HOME}/.config/alacritty"
    ln -svf $THIS_SCRIPT_LOCATION/alacritty ${HOME}/.config
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
setupNvim
buildVimCocPlugin
setupAlacritty
