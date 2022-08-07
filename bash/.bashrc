[[ $- == *i* ]] || return 0  # Interactive shells only.

shopt -s dotglob  # Globs match hidden files.
shopt -s extglob  # Enable extended globbing, e.g. !(*.html|*.css).
shopt -s globstar  # ** expands to any number of directories.

shopt -s histappend  # Don't truncate ~/.bash_history.
shopt -s lithist  # Embed newlines (not `;`) in multi-line history entries.

# If a command in a pipeline fails, set $? based on the [rightmost] failing
# command, rather than the final one (which might still have succeeded).
set -o pipefail


gumpf='*.7z|*.jar|*.rar|*.zip|*.gz|*.bzip|*.bz2|*.xz|*.lzma|*.cab|*.iso|*.tar|'
gumpf+='*.dmg|*.xpi|*.gem|*.egg|*.deb|*.rpm|*.msi|*.msm|*.msp|secring.*|*.m~|'
gumpf+='*.mex*|slprj|.hg|.hgignore|.hgsigs|.hgsub|.hgsubstate|.hgtags|*.tmp|'
gumpf+='~$*.doc*|~$*.xls*|*.xlk|~$*.ppt*|.DS_Store|.AppleDouble|.LSOverride|'
gumpf+='Icon\r\r|._*|.DocumentRevisions-V100|.fseventsd|.Spotlight-V100|'
gumpf+='.TemporaryItems|.Trashes|.VolumeIcon.icns|.AppleDB|.AppleDesktop|'
gumpf+='Network Trash Folder|Temporary Items|.apdisk|[._]*.s[a-w][a-z]|'
gumpf+='[._]s[a-w][a-z]|Session.vim|.netrwhist|*~|tags|DerivedData|*.pbxuser|'
gumpf+='*.mode1v3|*.mode2v3|*.perspectivev3|xcuserdata|*.moved-aside|'
gumpf+='*.xccheckout|*.xcscmblueprint|.git|node_modules|typings|__pycache__|'
gumpf+='coverage_report|htmlcov|_site|*.tu|*.tu-*'

alias c=clear
alias diff='diff --color=auto'
alias dr=docker
alias e=nvim
alias grep='grep --color=auto --exclude-dir=.git'
alias k=kubectl
alias l='ls --color=auto'
alias la='l -A'
alias ll=$'l -AhFl --time-style=\'+%Y-%m-%d %H:%M\n%a %d %b %H:%M\''
alias mk=minikube
alias printenv="printenv | sort | grep -Pe '^[A-Z][A-Z0-9_]*(?==)'"
alias q=exit
alias t="tree --gitignore -I \"$gumpf\""
alias vi=nvim
alias vim=nvim
alias vimdiff='nvim -d'
alias vd=vimdiff

unset gumpf


mkcd() {
    mkdir "$@" && cd "$_"
}


if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi

    if which kubectl &> /dev/null; then
        source <(kubectl completion bash)
        complete -o default -F __start_kubectl k
    fi
fi


# Support for paging compressed files (& more).
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"


GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=auto

[[ -f $HOME/.git-prompt.sh ]] && source "$HOME/.git-prompt.sh"

custom_prompt() {
    local raw_status=$? # Must come first!
    local raw_chroot=
    local raw_venv=
    local raw_host='\u@\h'
    local raw_path=$(pwd | sed -e "s|^${HOME}|~|" -re 's|([^/]{0,2})[^/]*/|\1/|g')
    local raw_branch=$(__git_ps1 '%s')

    if [[ -r /etc/debian_chroot ]]; then
        raw_chroot=$(cat /etc/debian_chroot)
    fi

    if [[ $VIRTUAL_ENV ]]; then
        raw_venv=$(basename "$VIRTUAL_ENV")
    fi

    local ARROW=$'\ue0b0'
    local BG='48;2;'
    local FG='38;2;'
    local RESET="\[\e[0m\]"
    local RESET_BG="\[\e[49m\]"

    if [[ "$BACKGROUND" == 'light' ]]; then
        local gruvbox_fg='60;56;54'
        local gruvbox_fg3='102;92;84'
        local gruvbox_gray='124;111;100'
        local gruvbox_bg1='235;219;178'
        local gruvbox_bg2='213;196;161'
        local gruvbox_bg3='189;174;147'
    else
        local gruvbox_fg='235;219;178'
        local gruvbox_fg3='189;174;147'
        local gruvbox_gray='168;153;132'
        local gruvbox_bg1='60;56;54'
        local gruvbox_bg2='80;73;69'
        local gruvbox_bg3='102;92;84'
    fi

    local gruvbox_white='235;219;178'
    local gruvbox_purple='177;98;134'
    local gruvbox_orange='214;93;14'
    local gruvbox_blue='69;133;136'
    local gruvbox_yellow='215;153;33'

    # Text colours.
    local STATUS_FG=$gruvbox_white
    local CHROOT_FG=$gruvbox_white
    local VENV_FG=$gruvbox_white
    local LOCAL_FG=$gruvbox_fg3
    local REMOTE_FG=$gruvbox_fg
    local PATH_FG=$gruvbox_gray
    local BRANCH_FG=$gruvbox_gray

    # Background colours.
    local STATUS_BG=$gruvbox_orange
    local CHROOT_BG=$gruvbox_purple
    local VENV_BG=$gruvbox_blue
    local LOCAL_BG=$gruvbox_bg3
    local REMOTE_BG=$gruvbox_yellow
    local PATH_BG=$gruvbox_bg2
    local BRANCH_BG=$gruvbox_bg1

    if [[ -n $SSH_CLIENT ]]; then
        local host_fg=$REMOTE_FG
        local host_bg=$REMOTE_BG
    else
        local host_fg=$LOCAL_FG
        local host_bg=$LOCAL_BG
    fi

    local pretty_status="\[\e[$FG$STATUS_FG;$BG${STATUS_BG}m\] $raw_status "
    local pretty_chroot="\[\e[$FG$CHROOT_FG;$BG${CHROOT_BG}m\] $raw_chroot "
    local pretty_venv="\[\e[$FG$VENV_FG;$BG${VENV_BG}m\] $raw_venv "
    local pretty_host="\[\e[$FG$host_fg;$BG${host_bg}m\] $raw_host "
    local pretty_path="\[\e[$FG$PATH_FG;$BG${PATH_BG}m\] $raw_path "
    local pretty_branch="\[\e[$FG$BRANCH_FG;$BG${BRANCH_BG}m\] $raw_branch "

    if [[ -n $raw_chroot ]]; then
        local status_arrow_bg=$CHROOT_BG
    elif [[ -n $raw_venv ]]; then
        local status_arrow_bg=$VENV_BG
    else
        local status_arrow_bg=$host_bg
    fi

    if [[ -n $raw_venv ]]; then
        local chroot_arrow_bg=$VENV_BG
    else
        local chroot_arrow_bg=$host_bg
    fi

    if [[ -n $raw_branch ]]; then
        local branch_arrow_fg=$BRANCH_BG
    else
        local branch_arrow_fg=$PATH_BG
    fi

    local status_arrow="\[\e[$FG$STATUS_BG;$BG${status_arrow_bg}m\]$ARROW"
    local chroot_arrow="\[\e[$FG$CHROOT_BG;$BG${chroot_arrow_bg}m\]$ARROW"
    local venv_arrow="\[\e[$FG$VENV_BG;$BG${host_bg}m\]$ARROW"
    local host_arrow="\[\e[$FG$host_bg;$BG${PATH_BG}m\]$ARROW"
    local path_arrow="\[\e[$FG$PATH_BG;$BG${BRANCH_BG}m\]$ARROW"
    local branch_arrow="\[\e[$FG${branch_arrow_fg}m\]$RESET_BG$ARROW"

    if [[ -z $raw_chroot ]]; then
        pretty_chroot=
        chroot_arrow=
    fi

    if [[ -z $raw_venv ]]; then
        pretty_venv=
        venv_arrow=
    fi

    if [[ $raw_status -eq 0 ]]; then
        pretty_status=
        status_arrow=
    fi

    if [[ -z $raw_branch ]]; then
        pretty_branch=
        path_arrow=
    fi

    PS1="$pretty_status$status_arrow$pretty_chroot$chroot_arrow"
    PS1="$PS1$pretty_venv$venv_arrow$pretty_host$host_arrow"
    PS1="$PS1$pretty_path$path_arrow$pretty_branch$branch_arrow$RESET "

    PS2="\[\e[$FG${gruvbox_gray};$BG${gruvbox_bg1}m\]...\[\e[$FG${gruvbox_bg1}m\]$RESET_BG$ARROW$RESET "
    PS3="\[\e[$FG${gruvbox_white};$BG${gruvbox_blue}m\] ${PS3:=Enter a number: }\[\e[$FG${gruvbox_blue}m\]$RESET_BG$ARROW$RESET "
    PS4="\[\e[$FG${gruvbox_white};$BG${gruvbox_blue}m\] $0:$LINENO \e[$FG${gruvbox_blue}m\]$RESET_BG$ARROW$RESET "

    # Set the window title.
    echo -n -e "\033]0;$raw_path\007"
}

PROMPT_COMMAND='custom_prompt;history -a'


if which dircolors &> /dev/null; then
    if [[ -r ~/.dircolors ]]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
fi

if which fortune sed &> /dev/null; then
    echo
    fortune | sed 's/^/  > /'
    echo
fi


if [[ -f $HOME/.bashrc_local ]]; then
    source "$HOME/.bashrc_local"
fi
