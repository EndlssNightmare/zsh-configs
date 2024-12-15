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

PROMPT=$'%{\e[0m%}%{\e[1;31m%}%n@%m%{\e[0m%} %{\e[1;31m%}%B$(get_ip)%b %b%{\e[1;31m%}%B[%b%{\e[1;37m%}%~%{\e[1;31m%}%B]%b%{\e[0m%} $(my_git_prompt_info)%{$reset_color%}%B»%b '
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

