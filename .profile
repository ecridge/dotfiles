##
# Set environment variables
##

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

export EDITOR="vim"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
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

# export PATH="$PATH:$HOME/.rvm/bin"
