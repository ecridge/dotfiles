# Bash-specific login items
export GLOBIGNORE='.:..'  # Stop .* from matching the . and .. directories.
export HISTCONTROL=ignoreboth  # Forget duplicate and space-prefixed commands.
export HISTFILESIZE=''  # Maximum number of commands saved in .bash_history.
export HISTSIZE=''  # Maximum number of commands to remember from one session.

# Shell-agnostic login items
if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

# Bash-specific non-login items
#
# Terminals opened within a graphical session essentially start here, but they
# inherit any environment variables from the login shell. (It's not guaranteed
# that the graphical login shell sourced ~/.profile, though.)
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi
