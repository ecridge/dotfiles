export EDITOR="vim"
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
