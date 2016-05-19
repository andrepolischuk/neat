PROMPT='$(prompt_user_host)%F{blue}%~%f $(git_prompt_status)$(git_prompt_info)%(?.%F{magenta}.%F{red})❯%f '

function prompt_user_host() {
  if [[ -n $SSH_CONNECTION ]]; then
    me="%n@%m"
  elif [[ $LOGNAME != $USER ]]; then
    me="%n"
  fi
  if [[ -n $me ]]; then
    echo "%F{magenta}$me%f:"
  fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{grey}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f%b "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{grey}◒ %f"
ZSH_THEME_GIT_PROMPT_ADDED="%F{cyan}✓ %f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{yellow}⚑ %f"
ZSH_THEME_GIT_PROMPT_DELETED="%F{red}✖ %f"
ZSH_THEME_GIT_PROMPT_RENAMED="%F{blue}➜ %f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{cyan}§ %f"
ZSH_THEME_GIT_PROMPT_AHEAD="%F{blue}𝝙 %f"
