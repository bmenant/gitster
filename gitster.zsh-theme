# vim:et sts=2 sw=2 ft=zsh
#
# Gitster theme
# https://github.com/bmenant/gitster
# Forked from
# https://github.com/shashankmehta/dotfiles/blob/master/thesetup/zsh/.oh-my-zsh/custom/themes/gitster.zsh-theme
#
# Requires the `prompt-pwd` and `git-info` zmodules to be included in the .zimrc file.

setopt nopromptbang prompt{cr,percent,sp,subst}

zstyle ':zim:prompt-pwd' git-root no 

typeset -gA git_info
if (( ${+functions[git-info]} )); then
  zstyle ':zim:git-info:branch' format '%b'
  zstyle ':zim:git-info:commit' format '%c'
  zstyle ':zim:git-info:clean' format '%F{green}='
  zstyle ':zim:git-info:dirty' format '%F{magenta}*'
  zstyle ':zim:git-info:ahead' format '%F{blue}+'
  zstyle ':zim:git-info:behind' format '%F{red}-'
  zstyle ':zim:git-info:keys' format \
      'prompt' ' %F{blue}%b%c %A%B%C%D'

  autoload -Uz add-zsh-hook && add-zsh-hook precmd git-info
fi

_prompt_user() {
  print -n "%(!:%F{magenta}:%F{gray})%n%f"
}

_prompt_host() {
  local current_hostname=''
  if [[ -n ${SSH_TTY} ]] current_hostname='%F{black}%m%f'
  if [[ -n ${TOOLBOX_PATH} ]] current_hostname='%F{magenta}%m%f'
  if [[ -n ${current_hostname} ]]; then
    print -n "${current_hostname}"
  else
    print -n 'localhost'
  fi
}

_prompt_status() {
  print -n "%(?:%F{green}%{%G↪%} 0:%F{red}%{%G↪%} %?)%f"
}

PS1='%B$(_prompt_status) $(_prompt_user)@$(_prompt_host) %F{black}$(prompt-pwd)${(e)git_info[prompt]}%f%b '
unset RPS1
