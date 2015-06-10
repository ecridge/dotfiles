[[ $- == *i* ]] || return 0 # Guard against non-interactive shells

##
# Customise command prompt
##

source "$HOME/.git-prompt.sh"

PROMPT_COMMAND="custom_prompt"

custom_prompt() {
  exit_code=$?
  message_string=""
  bash_version=$(echo $BASH_VERSION | sed -e 's/\([0-9]\.[0-9]\).*/\1/')
  window_title="bash $bash_version"
  if [ $exit_code -ne 0 ] ; then
    message_string="\[\e[31m\]exit $exit_code\[\e[0m\]\n"
  fi
  PS1="$message_string\u@\h:\w\[\e[32m\]\$(__git_ps1 "[%s]")\[\e[0m\]\$ "
  echo -n -e "\033]0;$window_title\007"
}

##
# Set aliases
##

alias clr="clear"
alias bundel="bundle"
alias grep="grep --color=auto"
alias ls="ls --color=auto"
alias la="ls -A"
alias ll="ls -AhFl --time-style='+%Y-%m-%d %H:%M
%a %d %b %H:%M'"
alias printenv="printenv | sort | grep -Pe '^[A-Z][A-Z0-9_]*(?==)'"
alias sudoa="sudo " # Create an alias of sudo that expands aliases
alias q="logout"
alias vd="vimdiff"

##
# Define custom functions
##

mkcd() {
  mkdir "$@" && cd "$_";
}

##
# Run login items
##

binsync > /dev/null

##
# Load RVM
##

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
