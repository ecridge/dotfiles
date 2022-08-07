export EDITOR=nvim
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
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

export PATH

eval `ssh-agent` > /dev/null
