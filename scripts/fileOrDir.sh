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

function previewDiff() {
  local entity="$(echo $1 | awk '{print $2}')"
  if [[ -d "${entity}" ]]
  then
    tree -C -L 2 "${entity}"
  fi
  if [[ -f "${entity}" ]]
  then
    if git ls-files --error-unmatch "${entity}" > /dev/null 2>&1
    then
      local staged=$(git diff --staged --name-only "${entity}")
      if [[ -z "${staged}" ]]
      then
        git diff "$entity" | delta --diff-highlight --line-numbers
      else
        git diff --cached "$entity" | delta --diff-highlight --line-numbers
      fi
    else
      bat --style=numbers --color=always "${entity}"
    fi
  fi
}
