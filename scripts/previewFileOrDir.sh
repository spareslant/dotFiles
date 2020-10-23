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

previewFileOrDir "$1"
