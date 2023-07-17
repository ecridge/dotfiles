# Login shells (not necessarily Bash) start here.

export EDITOR=nvim
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GLOBIGNORE='.:..'  # Stop .* from matching the . and .. directories.
export HISTCONTROL=ignoreboth  # Forget duplicate and space-prefixed commands.
export HISTFILESIZE=''  # Maximum number of commands saved in .bash_history.
export HISTSIZE=''  # Maximum number of commands to remember from one session.
export LC_TIME=en_DK.UTF-8
export LESS_TERMCAP_md=$'\033[01;38;5;109m'  # man pages: bold -> bold+blue
export LESS_TERMCAP_me=$'\033[0m'  # man pages: clear formatting
export LESS_TERMCAP_ue=$'\033[0m'  # man pages: clear underline
export LESS_TERMCAP_us=$'\033[03;38;5;142m'  # man pages: underline -> italic+green
export RIPGREP_CONFIG_PATH=~/.ripgreprc
export TZ=Europe/London

if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ]; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

export PATH

eval `ssh-agent` > /dev/null

if [ -f "$HOME/.profile_local" ]; then
    . "$HOME/.profile_local"
fi

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
