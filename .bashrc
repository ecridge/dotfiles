[[ $- == *i* ]] || return 0 # Guard against non-interactive shells

##
# Customise command prompt
##

PROMPT_COMMAND="custom_prompt"

[[ -f "$HOME/.git-prompt.sh" ]] && source "$HOME/.git-prompt.sh"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ] ; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

custom_prompt() {
  exit_code=$?
  message_string=""
  bash_version=$(echo $BASH_VERSION | sed -e 's/\([0-9]\.[0-9]\).*/\1/')
  window_title="Bash $bash_version  -  $PWD"
  if [ $exit_code -ne 0 ] ; then
    message_string="\[\e[31m\]exit $exit_code\[\e[0m\]\n"
  fi
  PS1="$message_string${debian_chroot:+($debian_chroot)}\u@\h:\w\[\e[32m\]\$(__git_ps1 "[%s]")\[\e[0m\]\$ "
  echo -n -e "\033]0;$window_title\007"
}

##
# Set aliases
##

alias alert='notify-send --urgency=low -i terminal "Bash: exit $?"'
alias clr="clear"
alias bundel="bundle"
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep="grep --color=auto"
alias ls="ls --color=auto"
alias la="ls -A"
alias ll="ls -AhFl --time-style='+%Y-%m-%d %H:%M
%a %d %b %H:%M'"
alias printenv="printenv | sort | grep -Pe '^[A-Z][A-Z0-9_]*(?==)'"
alias sudoa="sudo "
alias q="logout"
alias vd="vimdiff"

##
# Some Ubuntu defaults
##

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

shopt -s checkwinsize
#shopt -s globstar
shopt -s histappend

##
# Define custom functions
##

mkcd() {
  mkdir "$@" && cd "$_";
}

temp() {
  WRDS="$HOME/resources"
  if [[ -f "$WRDS/adjectives" && -f "$WRDS/animals" ]] ; then
    iAdj=$RANDOM
    nAdj=`grep -c "." $WRDS/adjectives`
    let "iAdj %= $nAdj"
    iAml=$RANDOM
    nAml=`grep -c "." $WRDS/animals`
    let "iAml %= $nAml"
    (( iAdj++, iAml++ ))
    NAME=`sed -n "$iAdj p" $WRDS/adjectives`-`sed -n "$iAml p" $WRDS/animals`
    mkdir -vm 700 $NAME
  else
    mktemp -dp . temp-XXXX
  fi
}

##
# Run login items
##

binsync > /dev/null

##
# Load RVM and friends
##

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# [[ -f "$HOME/.git-completion.bash" ]] && source "$HOME/.git-completion.bash"
