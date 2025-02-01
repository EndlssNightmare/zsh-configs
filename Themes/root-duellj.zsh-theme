# ZSH Theme - Preview: https://cl.ly/f701d00760f8059e06dc
# Thanks to gallifrey, upon whose theme this is based

local return_code="%(?..%{$fg_bold[red]%}%? ↵%{$reset_color%})"

function my_git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  GIT_STATUS=$(git_prompt_status)
  [[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function get_ip() {
  local network_interface=${NETWORK_INTERFACE:-eth0}
  vpn_ip=$(ip -4 addr show tun0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
  local_ip=$(ip -4 addr show "$network_interface" 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
  
  if [[ -n "$vpn_ip" ]]; then
    echo "[$vpn_ip]"
  elif [[ -n "$local_ip" ]]; then
    echo "[$local_ip]"
  else
    echo "[No IP]"
  fi
}

function update_prompt() {
  local venv_prefix=""

  if [[ -n "$VIRTUAL_ENV" ]]; then
    venv_name="${VIRTUAL_ENV##*/}"
    venv_prefix="%F{red}(%f%F{green}$venv_name%f%F{red})%f%F{red}─%f"
  fi

  PROMPT=$'%F{red}%B┌─'"$venv_prefix"$'%F{red}%B[%b%F{reset}%F{154}%n@%m%F{reset}%F{red}%B]%b%F{reset}%F{red} - %F{red}%B$(get_ip)%b - %b%F{red}%B[%b%F{white}%~%F{red}%B]%b%F{reset} $(my_git_prompt_info)%f
%F{red}%B└─%B[%F{magenta}#%F{red}%B]%F{reset}%b '
}

RPROMPT='[%*] '
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

precmd() {
  echo
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=") %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"

autoload -U add-zsh-hook
add-zsh-hook precmd update_prompt
add-zsh-hook chpwd update_prompt
