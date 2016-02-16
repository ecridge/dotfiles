##
# This file just sources ~/.profile and ~/.bashrc
##
# Environment variables that are needed by other shells (e.g. sh or graphical
# logins) need to be in ~/.profile. There shouldn't be anything in here that
# is specific to Bash.
# 
# Bash-specific code that you'd want in an interactive command line goes in
# ~/.bashrc; this includes the command prompt, EDITOR variable and personal
# aliases. ~/.bashrc should not generate any output.
#
# The file ~/.bash_login should not exist.
##

if [ -f "$HOME/.profile" ]; then
  . "$HOME/.profile"
fi

if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi
