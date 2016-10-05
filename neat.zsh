# Prompt symbol
NEAT_PROMPT_SYMBOL="❯"

# Git status symbols
ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{grey}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f%b "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{grey}⋯ %f"
ZSH_THEME_GIT_PROMPT_ADDED="%F{green}✓ %f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{yellow}⚑ %f"
ZSH_THEME_GIT_PROMPT_DELETED="%F{red}✖ %f"
ZSH_THEME_GIT_PROMPT_RENAMED="%F{blue}➜ %f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{red}‼ %f"
ZSH_THEME_GIT_PROMPT_AHEAD="%F{blue}↑ %f"
ZSH_THEME_GIT_PROMPT_BEHIND="%F{blue}↓ %f"

# Username
neat_user() {
  if [[ $USER == 'root' ]]; then
    echo -n "%B%F{red}"
  else
    echo -n "%B%F{magenta}"
  fi

  echo -n "%n%f%b"
}

# Username and ssh host
neat_host() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo -n "$(neat_user)"
    echo -n "%B%F{grey}@%m%f%b "
  elif [[ $LOGNAME != $USER ]] || [[ $USER == 'root' ]]; then
    echo -n "$(neat_user) "
  fi
}

# Current directory
neat_current_dir() {
  echo -n "%F{cyan}%~%f "
}

# Git status
neat_git_status() {
  echo -n "$(git_prompt_status)$(git_prompt_info)"
}

# Prompt symbol
neat_return_status() {
  echo -n "%(?.%F{yellow}.%F{red})$NEAT_PROMPT_SYMBOL%f "
}

# Battery status
neat_battery_status() {
  if [[ `uname` == 'Linux' ]]; then
    current_charge=$(cat /proc/acpi/battery/BAT1/state | grep 'remaining capacity' | awk '{print $3}')
    total_charge=$(cat /proc/acpi/battery/BAT1/info | grep 'last full capacity' | awk '{print $4}')
    is_charging=$(cat /proc/acpi/battery/BAT1/state | grep 'charging state.*charging')
  else
    battery_info=`ioreg -rc AppleSmartBattery`
    current_charge=$(echo $battery_info | grep -o '"CurrentCapacity" = [0-9]\+' | awk '{print $3}')
    total_charge=$(echo $battery_info | grep -o '"MaxCapacity" = [0-9]\+' | awk '{print $3}')
    is_charging=$(echo $battery_info | grep -o '"IsCharging" = Yes')
  fi

  charged_percentage=$(echo "(($current_charge/$total_charge)*100)" | bc -l | cut -d '.' -f 1)

  if [[ $charged_percentage -gt 100 ]]; then
    charged_percentage=100
  fi

  if [[ $charged_percentage -lt 25 ]]; then
    if [ -z $is_charging ]; then
      echo -n "%F{red}⚡%f"
    fi
  fi
}

# Compose prompt
PROMPT='$(neat_host)$(neat_current_dir)$(neat_git_status)$(neat_return_status)'

# Compose right prompt
RPROMPT='$(neat_battery_status)'

# Compose interactive prompt
PS2='%F{yellow}$NEAT_PROMPT_SYMBOL%f '
