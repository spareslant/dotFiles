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

function fzf_bin() {
  header="⟰ $(pwd)"
  fzf --header="$header" "$@"
}

# ==== Open file/dir. Based on type of file it either cd to directory of opens file in vim when <Enter> is pressed
function fzOpenFileOrDir() {
  fzf_bin --preview="source $UTILITY_SCRIPT; previewFileOrDir {}" --preview-window='wrap' | openFileOrDir
}

# ==== Preview file/dir. Selected files will also be copied in system clipboard
function fzPreviewFilesOrDirsAndCopy() {
  #fzf_bin --multi --preview="source $UTILITY_SCRIPT; previewFileOrDir {}" --preview-window='wrap' --bind 'ctrl-o:execute(vim -R -o {})' | tee >(pbcopy)
  fzf_bin --multi --preview="source $UTILITY_SCRIPT; previewFileOrDir {}" --preview-window='wrap' | tee >(pbcopy)
}

# ==== Directory listing and switching
function fzChangeDir() {
  fd -t d -H -I --exclude .git | fzf_bin --preview="source $UTILITY_SCRIPT; previewFileOrDir {}" --preview-window='wrap' | openFileOrDir
}

# ==== Open multiple files in vim in their own respective windows. (Note: use :only in vim to all others)
function fzOpenMultiFilesInVim() {
  local filesList=$(mktemp -t fzf)
  fd -H -I -t f --exclude .git | fzf_bin --multi --preview="source $UTILITY_SCRIPT; previewFileOrDir {}" --preview-window='wrap' > "$filesList"
  vim -o $(cat "$filesList")
  rm -f "$filesList"
}

# ==== Changes the directory from current directory ownwards and also previews its underneath tree structure.
#function fzcd() {
#  cd $(fd -t d -H -I --exclude .git | fzf_bin--preview='tree -C -L 2 {}' --preview-window='wrap') && echo $PWD
#}

# ==== Changes the directory from HOME directory ownwards and also previews its underneath tree structure.
function fzChangeDirFromHome() {
  cd $(fd -t d -H -I --exclude .git '' $HOME/ | fzf_bin --preview='tree -C -L 2 {}' --preview-window='wrap') && echo $PWD
}

# ==== Grep word from all files in current directory and passes onto fzf for selection. Selected files will also be copied in system clipboard
function fzPreviewGreppedFiles() {
  [[ -z "$1" ]] && echo "usage is ./fzPreviewGreppedFiles <string>" && return 1
  local item="$1"
  rg --no-messages $item -l | fzf_bin --multi --preview-window='wrap' --preview="source $UTILITY_SCRIPT; previewFileOrDir {} | rg $item --color=always -C 2 --context-separator='~~~~~~~~~ SKIPPED CONTENT ~~~~~~~~~' " | tee >(pbcopy)
}

# ==== Do operation interactively on grepped files in vim. Additionaly select grepped files via fzf
function fzOperateOnSelectedGreppedFiles() {
  [[ -z "$1" ]] && echo "usage is ./fzOperateOnSelectedGreppedFiles <string>" && return 2
  local item="$1"
  local quickFixFile=$(mktemp -t fzf)
  rg --no-messages "$item" --vimgrep $(fzPreviewGreppedFiles "$item") > "$quickFixFile"
  vim -q "$quickFixFile" -c ":copen"
  rm -f "$quickFixFile"
}

# ==== Do operation interactively on grepped files in vim
function fzOperateOnGreppedFiles() {
  [[ -z "$1" ]] && echo "usage is ./fzOperateOnAllGreppedFiles <string>" && return 3
  local item="$1"
  local quickFixFile=$(mktemp -t fzf)
  rg --no-messages "$item" --vimgrep > "$quickFixFile"
  vim -q "$quickFixFile" -c ":copen"
  rm -f "$quickFixFile"
}

# ==== Do operation interactively on selected files in vim. 
function fzOperateOnSelectedFiles() {
  local quickFixFile=$(mktemp -t fzf)
  fd -H -I -t f --exclude .git | fzf_bin --multi --preview="source $UTILITY_SCRIPT; previewFileOrDir {}" --preview-window='wrap' > "$quickFixFile"
  vim -c ':set errorformat+=%f | :cexpr system("cat '$quickFixFile'") | copen'
  rm -f "$quickFixFile"
}

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
