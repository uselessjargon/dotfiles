#! bash oh-my-bash.module

# Axin Bash Prompt, inspired by theme "Sexy" and "Bobby"
# thanks to them

if [[ $COLORTERM = gnome-* && $TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then export TERM=gnome-256color
elif [[ $TERM != dumb ]] && infocmp xterm-256color >/dev/null 2>&1; then export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
      MAGENTA=$(tput setaf 9)
      ORANGE=$(tput setaf 172)
      GREEN=$(tput setaf 190)
      PURPLE=$(tput setaf 141)
      WHITE=$(tput setaf 0)
    else
      MAGENTA=$(tput setaf 5)
      ORANGE=$(tput setaf 4)
      GREEN=$(tput setaf 2)
      PURPLE=$(tput setaf 1)
      WHITE=$(tput setaf 7)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

function k8s_info() {
    local k8s_data=$(kubectl config view --minify --output 'jsonpath={..namespace}@{.current-context}' 2> /dev/null)
    if k8s_data != ""; then
        echo "[$(k8s_data)]"
    fi
}

function _omb_theme_PROMPT_COMMAND() {
  PS1="\[${BOLD}${MAGENTA}\]\u \[$WHITE\]@ \[$ORANGE\]\h \[$WHITE\]in \[$GREEN\]\w\[$WHITE\]\[$SCM_THEME_PROMPT_PREFIX\]$(clock_prompt) \[$PURPLE\]\$(scm_prompt_info) $YELLOW\$(k8s_info)$PURPLE\n\$ \[$RESET\]"
}
THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"${_omb_prompt_white}"}

_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND
