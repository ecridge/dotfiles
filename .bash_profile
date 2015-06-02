##
# Add user binaries to PATH
##

if [ -d "$HOME/bin" ] ; then                                                       
  PATH="$HOME/bin:$PATH"                                                         
fi


##
# Remove working direcrory stem from terminal titlebar
##

unset PROMPT_COMMAND


##
# Customise command prompt
##

PROMPT_COMMAND="custom_prompt"

custom_prompt() {
  exit_code=$?
  message_string=""
  bash_version=$(echo $BASH_VERSION | sed -e 's/\([0-9]\.[0-9]\).*/\1/')
  window_title="bash $bash_version"
  if [ $exit_code -ne 0 ] ; then
    message_string="\[\e[31m\]exit $exit_code\[\e[0m\]\n"
  fi
  PS1="$message_string\u@\h:\w\$ "
  echo -n -e "\033]0;$window_title\007"
}


##
# Set aliases
##

alias clr='clear'
alias q='logout'
alias vim='mvim -f'

## Uncomment if using BSD coreutils
#export CLICOLOR=1
#export LSCOLORS=ExgxfxdacxDaDaxbadacec
#alias ls='ls -G'
#alias la='ls -A'
#alias ll='ls -AhFl'
#alias grep='grep -nP'

## Uncomment if using GNU coreutils
alias ls="ls --color=auto"
alias la="ls -A"
alias ll="ls -AhFl --time-style='+%Y-%m-%d %H:%M
%a %d %b %H:%M'"
alias grep="grep -nP --color=auto"

## Uncomment for an alias of sudo that expands aliases
alias sudoa='sudo '


##
# Run login items
##

binsync > /dev/null


##
# Load RVM
##

export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
