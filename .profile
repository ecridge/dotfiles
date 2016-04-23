# Set environment variables.
export EDITOR="vim"
export GIT_PS1_HIDE_IF_PWD_IGNORED="true"
export GIT_PS1_SHOWDIRTYSTATE="true"
export GIT_PS1_SHOWSTASHSTATE="true"
export GIT_PS1_SHOWUNTRACKEDFILES="true"
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_STATESEPARATOR="]["
export HOMEBREW_GITHUB_API_TOKEN="***REMOVED***"
export RI="--format ansi --width 79"
export RI_PAGER="less -r"
export TZ="Europe/London"

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
