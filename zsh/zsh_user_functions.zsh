#! /bin/zsh

# Although this script is used by zshrc file but it can be safely sourced independently as well

if [[ -z "${DOT_FILE_LOC}" ]]
then
    this_script_loc=$(cd $(dirname $0) && pwd)
    script_name=$(basename $0)
    local nonSymLinkabsoluteLoc=$(greadlink -f "$this_script_loc/$script_name")
    local DOT_FILES_LOC=$(echo $nonSymLinkabsoluteLoc | perl -wnl -e 'm!(.+)/.+/.+$! and print $1')
    export DOT_FILES_LOC=$DOT_FILES_LOC
fi

UTILITY_SCRIPT="${DOT_FILES_LOC}/scripts/fileOrDir.sh"
source ${DOT_FILES_LOC}/scripts/fileOrDir.sh

#=============== fzf custom settings ===============#
# Using modified Jellybeans theme for fzf
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'
export FZF_DEFAULT_OPTS="--prompt='[!]filter: ᯼ ⫸  ' --pointer='⮀' --marker='✔' \
    --color fg:188,bg:232,hl:87,fg+:221,bg+:232,hl+:87 \
    --color info:181,prompt:117:bold,spinner:107,pointer:220,marker:209 \
    --color header:148:bold \
    --color gutter:232 \
    --preview-window='wrap'"

# ==== Git add
function git_add() {
    git add $(git status -s | fzf --multi --preview="source $UTILITY_SCRIPT; previewDiff {}" --preview-window='wrap' | awk '{print $2}')
    git status
}

# ==== Git diff
function git_diff() {
    git status -s | fzf --multi --preview="source $UTILITY_SCRIPT; previewDiff {}" --preview-window='wrap'
    git status
}
# ==== Git fuzzy settings
function gitFuzzyBinLoc() {
    local DOT_FILES_LOC=$(dotFilesLoc)
    echo "${DOT_FILES_LOC}/downloaded/extraShellUtilities/git-fuzzy/bin"
}
GIT_FUZZY_BIN_PATH=$(gitFuzzyBinLoc)
export PATH="$GIT_FUZZY_BIN_PATH:$PATH"
export GF_PREFERRED_PAGER="delta --diff-highlight --line-numbers"

# ==== nnn settings
function export_nnn_variables() {
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi
    export EDITOR=nvim
    export VISUAL=nvim
    export NNN_FIFO='/tmp/nnn.fifo'
    export NNN_COLORS="1234"
    export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
    export NNN_PLUG='p:fz-preview-open;c:fz-preview-cd;v:preview-tui-ext'
    export NNN_OPENER="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/plugins/nuke"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (if required, see `stty -a`) to Quit nnn
    stty start undef
    stty stop undef
}

function n() {
    export_nnn_variables
    nnn -d "$@"
    if [ -f "$NNN_TMPFILE" ]; then
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# ==== aliases
if which exa > /dev/null 2>&1
then
    alias ll="exa --git --group --icons -smod -l"
fi

if which bat > /dev/null 2>&1
then
    alias cat="bat -pP"
fi

if which nvim > /dev/null 2>&1
then
    alias nv="nvim"
fi
