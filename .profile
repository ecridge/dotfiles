export EDITOR="vim"
export GIT_PS1_HIDE_IF_PWD_IGNORED="true"
export GIT_PS1_SHOWDIRTYSTATE="true"
export GIT_PS1_SHOWSTASHSTATE="true"
export GIT_PS1_SHOWUNTRACKEDFILES="true"
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_STATESEPARATOR="]["
export RI="--format ansi --width 78"
export RI_PAGER="less -r"
export TZ="Europe/London"

##
# Add user binaries to PATH
##

if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

##
# Add RVM to PATH
##

export PATH="$PATH:$HOME/.rvm/bin"
