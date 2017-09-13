# Set environment variables.
export EDITOR=nvim
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GIT_PS1_HIDE_IF_PWD_IGNORED=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=auto
export GLOBIGNORE='.:..'  # Stop .* from matching the . and .. directories.
export HISTCONTROL=ignoreboth  # Forget duplicate and space-prefixed commands.
export HISTFILESIZE=1000  # Maximum number of commands saved in .bash_history.
export HISTSIZE=500  # Maximum number of commands to remember from one session.
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export RI='--format ansi --width 79'
export RI_PAGER='less -r'
export TZ=Europe/London

# Set private environment variables.
if [ -f "$HOME/private/.secrets" ]; then
    . "$HOME/private/.secrets"
fi

# Add brew sbin to PATH.
if [ -d "/usr/local/sbin" ]; then
    PATH="/usr/local/sbin:$PATH"
fi

# Use the GNU toolchain.
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Add user binaries to PATH.
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# Add Go packages to PATH.
PATH="$PATH:/usr/local/opt/go/libexec/bin"

# Export final paths to subshells.
export PATH
export MANPATH
