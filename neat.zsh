PROMPT='$(prompt_user_host)%F{blue}%~%f $(git_prompt_status)$(git_prompt_info)%(?.%F{magenta}.%F{red})❯%f '
RPROMPT='$(prompt_battery_status)'

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

function prompt_battery_status() {
  if [[ `uname` == 'Linux' ]]; then
    current_charge=$(cat /proc/acpi/battery/BAT1/state | grep 'remaining capacity' | awk '{print $3}')
    total_charge=$(cat /proc/acpi/battery/BAT1/info | grep 'last full capacity' | awk '{print $4}')
  else
    battery_info=`ioreg -rc AppleSmartBattery`
    current_charge=$(echo $battery_info | grep -o '"CurrentCapacity" = [0-9]\+' | awk '{print $3}')
    total_charge=$(echo $battery_info | grep -o '"MaxCapacity" = [0-9]\+' | awk '{print $3}')
  fi

  charged_percentage=$(echo "(($current_charge/$total_charge)*100)" | bc -l | cut -d '.' -f 1)

  if [[ $charged_percentage -gt 100 ]]; then
    charged_percentage=100
  fi
  if [[ $charged_percentage -lt 25 ]]; then
    echo "%F{red}⚡%f"
  fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{grey}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f%b "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{grey}⋯ %f"
ZSH_THEME_GIT_PROMPT_ADDED="%F{cyan}✓ %f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{yellow}⚑ %f"
ZSH_THEME_GIT_PROMPT_DELETED="%F{red}✖ %f"
ZSH_THEME_GIT_PROMPT_RENAMED="%F{blue}➜ %f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{cyan}‼ %f"
ZSH_THEME_GIT_PROMPT_AHEAD="%F{blue}↑ %f"
ZSH_THEME_GIT_PROMPT_BEHIND="%F{blue}↓ %f"
