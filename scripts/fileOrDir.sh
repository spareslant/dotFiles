#! /bin/bash

function previewFileOrDir() {
  local entity="$1"
  if [[ -d "${entity}" ]]
  then
    tree -C -L 2 "${entity}"
  fi
  if [[ -f "${entity}" ]]
  then
    bat --style=numbers --color=always "${entity}"
  fi
}

function openFileOrDir() {
  # take input from STDIN (piped-in | )
  entity=$(cat -)
  if [[ -d "${entity}" ]]
  then
    cd "${entity}"
  else
    # below command will also work.
    #echo "$entity" | xargs -o vim
    vim < /dev/tty "$entity"
  fi
}
