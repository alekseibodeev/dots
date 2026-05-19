[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias mv='mv -i'
alias cp='cp -i'
alias cal='cal -m'
alias open='xdg-open'

ATTRIBUTE_BOLD='\[\e[1m\]'
ATTRIBUTE_RESET='\[\e[0m\]'
COLOR_DEFAULT='\[\e[39m\]'
COLOR_GREEN='\[\e[32m\]'
COLOR_BLUE='\[\e[34m\]'

PS1="${ATTRIBUTE_BOLD}[${COLOR_GREEN}\u@\h${COLOR_DEFAULT}:${COLOR_BLUE}\W${COLOR_DEFAULT}]\$${ATTRIBUTE_RESET} "

eval "$(fzf --bash)"
