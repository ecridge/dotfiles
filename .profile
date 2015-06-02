export TZ="Europe/London"
export EDITOR="vim"

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
