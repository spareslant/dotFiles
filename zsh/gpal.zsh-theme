# ZSH Theme - Preview: https://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
#local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m %{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n@%m %{$reset_color%}'
    local user_symbol='$'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%}%~ %{$reset_color%}'
#local git_branch='$(git_prompt_info)'
local git_branch='$(git_super_status)'

function get_rvm_ruby_prompt {
  local ruby_version=$(ruby_prompt_info| perl -wnl -e 'm!\-(.+)\)$! and print $1')
  if [[ ! -z "${ruby_version}" ]]
  then
    echo "${ZSH_THEME_CUSTOM_RUBY_PROMPT_PREFIX}${ruby_version}${ZSH_THEME_CUSTOM_RUBY_PROMPT_SUFFIX}"
  fi
}

function get_rbenv_ruby_prompt {
  local ruby_version=$(rbenv_prompt_info | perl -wnl -e 'm!\((.+)\)! and print $1')
  if [[ ! -z "${ruby_version}" ]]
  then
    echo "${ZSH_THEME_CUSTOM_RUBY_PROMPT_PREFIX}${ruby_version}${ZSH_THEME_CUSTOM_RUBY_PROMPT_SUFFIX}"
  fi
}

function get_oci_prompt {
  if [[ ! -z $OCIENV ]]
  then
    echo "${ZSH_THEME_OCI_PROMPT_PREFIX}${OCIENV}${ZSH_THEME_OCI_PROMPT_SUFFIX}"
  fi
}

function get_python_prompt {
  local python_version=$(pyenv_prompt_info)
  if [[ ! -z "${python_version}" ]]
  then
    echo "${ZSH_THEME_PYTHON_PROMPT_PREFIX}${python_version}${ZSH_THEME_PYTHON_PROMPT_SUFFIX}"
  fi
}

function get_kubectx_prompt {
  local kube_ctx=$(kubectx_prompt_info 2> /dev/null)
  if [[ ! -z "${kube_ctx}" ]]
  then
    echo "${ZSH_THEME_KUBECTX_PROMPT_PREFIX}${kube_ctx}${ZSH_THEME_KUBECTX_PROMPT_SUFFIX}"
  fi
}

function get_nodejs_prompt {
  local nodejs_version=$(nvm_prompt_info)
  if [[ ! -z "${nodejs_version}" ]]
  then
    echo "${ZSH_THEME_NODEJS_PROMPT_PREFIX}${nodejs_version}${ZSH_THEME_NODEJS_PROMPT_SUFFIX}"
  fi
}

local rvm_ruby_prompt='$(get_rvm_ruby_prompt)'
local rbenv_ruby_prompt='$(get_rbenv_ruby_prompt)'
local venv_prompt='$(virtualenv_prompt_info)'
local pyenv_prompt='$(get_python_prompt)'
local kubectx_prompt='$(get_kubectx_prompt)'
local nodejs_prompt='$(get_nodejs_prompt)'
local oci_prompt='$(get_oci_prompt)'

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

PROMPT="╭─${user_host}${current_dir}${git_branch}${rvm_ruby_prompt}${rbenv_ruby_prompt}${venv_prompt}${pyenv_prompt}${nodejs_prompt}${kubectx_prompt}${oci_prompt}
╰─%B${user_symbol}%b "
#RPROMPT="%B${return_code}%b"
RPROMPT="%B%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹שׂ "
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

# https://dev.to/yujinyuz/custom-colors-in-oh-my-zsh-themes-4h13
# run spectrum_ls command to get the color codes
ZSH_THEME_OCI_PROMPT_PREFIX="%{$FG[225]%}‹ "
ZSH_THEME_OCI_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_PYTHON_PROMPT_PREFIX="%{$FG[153]%}‹ "
ZSH_THEME_PYTHON_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_KUBECTX_PROMPT_PREFIX="%{$FG[045]%}‹ﴱ "
ZSH_THEME_KUBECTX_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_CUSTOM_RUBY_PROMPT_PREFIX="%{$FG[161]%}‹ "
ZSH_THEME_CUSTOM_RUBY_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_NODEJS_PROMPT_PREFIX="%{$FG[070]%}‹⬢ "
ZSH_THEME_NODEJS_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%}‹🐍 "
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX
