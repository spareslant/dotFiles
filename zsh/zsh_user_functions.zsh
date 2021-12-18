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
  [[ $# -eq 0 ]] && echo "usage is ./fzOperateOnAllGreppedFiles [rg-options] <string>" && return 1
  local item=$@
  rg --no-messages "$@" -l | fzf_bin --multi --preview-window='wrap' --preview="source $UTILITY_SCRIPT; previewFileOrDir {} | rg $item --color=always -C 2 --context-separator='~~~~~~~~~ SKIPPED CONTENT ~~~~~~~~~' " | tee >(pbcopy)
}

# ==== Do operation interactively on grepped files in vim. Additionaly select grepped files via fzf
function fzOperateOnSelectedGreppedFiles() {
  [[ $# -eq 0 ]] && echo "usage is ./fzOperateOnAllGreppedFiles [rg-options] <string>" && return 2
  local quickFixFile=$(mktemp -t fzf)
  rg --no-messages "$@" --vimgrep $(fzPreviewGreppedFiles "$@") > "$quickFixFile"
  vim -q "$quickFixFile" -c ":copen"
  rm -f "$quickFixFile"
}

# ==== Do operation interactively on grepped files in vim
function fzOperateOnGreppedFiles() {
  [[ $# -eq 0 ]] && echo "usage is ./fzOperateOnAllGreppedFiles [rg-options] <string>" && return 3
  local quickFixFile=$(mktemp -t fzf)
  rg --no-messages "$@" --vimgrep > "$quickFixFile"
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

# ==== nnn settings
function export_nnn_variables() {
  if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
    echo "nnn is already running"
    return
  fi
  export EDITOR=vim
  export VISUAL=vim
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

function activate_base16_shell() {
  BASE16_SHELL="${DOT_FILES_LOC}/downloaded/extraShellUtilities/base16-shell/"
  [ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    eval "$("$BASE16_SHELL/profile_helper.sh")"
}

function set_base16_tmux_theme() {
  local theme="$1"
  local tmux_conf_changed=false
  if [[ -f ${DOT_FILES_LOC}/rendered_configs/tmux.conf ]]
  then

    # check the change in tmux.conf template
    diff -b ${DOT_FILES_LOC}/rendered_configs/tmux.conf ${DOT_FILES_LOC}/tmux/tmux.conf.template \
        | egrep -v '> source.+conf|^\d' > /dev/null \
        && tmux_conf_changed=false \
        || tmux_conf_changed=true

    if [[ $tmux_conf_changed ]]
    then
        cat ${DOT_FILES_LOC}/tmux/tmux.conf.template > ${DOT_FILES_LOC}/rendered_configs/tmux.conf
        echo "source ${DOT_FILES_LOC}/downloaded/extraShellUtilities/base16-tmux/colors/${theme}.conf" \
            >> ${DOT_FILES_LOC}/rendered_configs/tmux.conf
    fi

    if egrep 'source.+conf$' ${DOT_FILES_LOC}/rendered_configs/tmux.conf > /dev/null
    then
      perl -wpl -s -i \
          -e 's!(^source\s+.+/)(.+?)(\.conf)$!$1$theme$3!' -- -theme="${theme}" \
          ${DOT_FILES_LOC}/rendered_configs/tmux.conf
    fi
  else
    cat ${DOT_FILES_LOC}/tmux/tmux.conf.template > ${DOT_FILES_LOC}/rendered_configs/tmux.conf
    echo "source ${DOT_FILES_LOC}/downloaded/extraShellUtilities/base16-tmux/colors/${theme}.conf" \
        >> ${DOT_FILES_LOC}/rendered_configs/tmux.conf
  fi
}

# ==== aliases
if which lsd > /dev/null 2>&1
then
  alias ls=lsd
fi

#if which bat > /dev/null 2>&1
#then
#  alias cat=bat
#fi
