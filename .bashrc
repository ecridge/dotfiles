# Guard against non-interactive shells.
[[ $- == *i* ]] || return 0


# Set shell options.
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob  # Globs match hidden files.
shopt -s extglob  # Enable extended globbing, e.g. !(*.html|*.css).
shopt -s lithist
shopt -s no_empty_cmd_completion
shopt -s nullglob  # Don’t take non-matching globs literally.
shopt -s globstar  # ** expands to any number of directories.
shopt -s histappend


# Check whether this is a documented chroot environment.
if [[ -z ${debian_chroot:-} && -r /etc/debian_chroot ]]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


# Customise command prompt.
[[ -f $HOME/.git-prompt.sh ]] && source "$HOME/.git-prompt.sh"
PROMPT_COMMAND='custom_prompt;history -a'
custom_prompt() {
    exit_code=$?

    bash_version=$(echo $BASH_VERSION | sed -e 's/\([0-9.]*\)(.*/\1/')
    msg=${debian_chroot:+($debian_chroot)}
    short_path=$(pwd | sed -e "s|^${HOME}|~|" -re 's|([^/]{0,2})[^/]*/|\1/|g')
    window_title="Bash $bash_version  –  $(pwd | grep -o '[^/]\+$')"

    if [[ $exit_code -ne 0 ]]; then
        msg="\[\e[31m\]exit $exit_code\[\e[0m\]\n$msg"
    fi

    PS1="$msg\u@\h:$short_path\[\e[32m\]\$(__git_ps1 '[%s]')\[\e[0m\]\$ "

    echo -n -e "\033]0;$window_title\007"
}


# Load colour profile for ls.
if which dircolors > /dev/null; then
    if [[ -r ~/.dircolors ]]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
fi


# Set aliases.
alias alert='notify-send --urgency=low -i terminal "Bash: exit $?"'
alias ascii="grep -ne '[^ -~]'"  # Highlight non-ASCII characters in a file.
alias clr=clear
alias chdom=chmod  # Common typo.
alias chrome=google-chrome
alias bundel=bundle  # Another typo.
alias electron=node_modules/.bin/electron
alias grep='grep --color=auto --exclude-dir=.git'
alias ls='ls --color=auto'
alias la='ls -A'
alias ll="ls -AhFl --time-style='+%Y-%m-%d %H:%M
%a %d %b %H:%M'"  # Newline is necessary.
alias mdl='mdl --style ~/.mdstyle'
alias printenv="printenv | sort | grep -Pe '^[A-Z][A-Z0-9_]*(?==)'"
alias py='clear && python'
alias sudoa='sudo '  # An alias of sudo that expands aliases.
alias q=logout
alias tree="tree -I '.DS_Store|.AppleDouble|.LSOverride|._*|.DocumentRevisions\
-V100|.fseventd|.Spotlight-V100|.TemporaryItems|.Trashes|.VolumeIcon.icns|.App\
leDB|.AppleDesktop|Network Trash Folder|Temporary Items|.apdisk|.localized|[._\
]*.?s[a-w][a-z]|Session.vim.netrwhist|*~|tags|node_modules|.git'"
alias vd=vimdiff


# Function to make a new directory and change into it.
mkcd() {
    mkdir "$@" && cd "$_"
}


# Function to make a new directory with a memorable name.
temp() {
    SRC="$HOME/resources"
    if [[ -f $SRC/adjectives && -f $SRC/animals ]]; then
        iAdj=$RANDOM
        nAdj=$(grep -c "." $SRC/adjectives)
        (( iAdj %= nAdj ))
        iAml=$RANDOM
        nAml=$(grep -c "." $SRC/animals)
        (( iAml %= nAml ))
        (( iAdj++, iAml++ ))
        NAME=$(sed -n "$iAdj p" $SRC/adjectives)
        NAME=${NAME}-$(sed -n "$iAml p" $SRC/animals)
        mkdir -vm 700 $NAME
    else
        mktemp -dp . temp-XXXX
    fi
}


# Run login items.
binsync > /dev/null


# Other things that need loading.
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"
[[ -f $HOME/.git-completion.bash ]] && source "$HOME/.git-completion.bash"


# Exit cleanly.
true
