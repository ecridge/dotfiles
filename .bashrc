# Guard against non-interactive shells.
[[ $- == *i* ]] || return 0


# Set shell options.
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob  # Globs match hidden files.
shopt -s extglob  # Enable extended globbing, e.g. !(*.html|*.css).
shopt -s lithist
shopt -s no_empty_cmd_completion
#shopt -s nullglob  # Incompatible with the Ubuntu bash-completion package.
shopt -s globstar  # ** expands to any number of directories.
shopt -s histappend

set -o pipefail


# List boring files.
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
gumpf+='coverage_report|htmlcov|_site|*.tu'


# Set aliases.
alias ag='ag -s'  # Case-sensitive by default.
alias alert='notify-send --urgency=low -i terminal "Bash: exit $?"'
alias ascii="ag '[^ -~\\n]'"  # Highlight non-ASCII characters in a file.
alias aq='ag -Q'  # Match literals instead of regexen.
alias c=clear
alias chdom=chmod  # Common typo.
alias chrome=google-chrome
alias dc=docker-compose
alias diff='diff --color=auto'
alias dr=docker
alias e=nvim
alias get="curl -sSi -X GET -H 'Accept: application/json'"
alias grep='grep --color=auto --exclude-dir=.git'
alias ie='nvim --noplugin'
alias k=kubectl
alias l='ls --color=auto'
alias la='l -A'
alias ll=$'l -AhFl --time-style=\'+%Y-%m-%d %H:%M\n%a %d %b %H:%M\''
alias m=man
alias mk=minikube
alias mdl='mdl --style ~/.mdstyle'
alias n=npm
alias o=open
alias post="curl -sSi -X POST -H 'Content-type: application/json' -d"
alias printenv="printenv | sort | grep -Pe '^[A-Z][A-Z0-9_]*(?==)'"
alias put="curl -sSi -X PUT -H 'Content-type: application/json' -d"
alias py='clear && bpython'
alias py3='clear && bpython3'
alias sk=skaffold
alias sudoa='sudo '  # An alias of sudo that expands aliases.
alias q=exit
alias t="tree -I \"$gumpf\""
alias vi=nvim
alias vim=nvim
alias vimdiff='nvim -d'
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

# Enable programmable completion.
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi


source <(kubectl completion bash)
complete -o default -F __start_kubectl k


# Set up pyenv and pyenv-virtualenv.
if which pyenv &> /dev/null; then
    eval "$(pyenv init --path)"
    if [[ -d $(pyenv root)/plugins/pyenv-virtualenv ]]; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi


# Other things that need loading.
if which rbenv &> /dev/null; then eval "$(rbenv init -)"; fi
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
[[ -f $HOME/.bowman.bash ]] && source "$HOME/.bowman.bash"
if which fasd &> /dev/null; then eval "$(fasd --init auto)"; fi


# Customise command prompt.
[[ -f $HOME/.git-prompt.sh ]] && source "$HOME/.git-prompt.sh"
PROMPT_COMMAND='custom_prompt;history -a'
custom_prompt() {
    local raw_status=$? # Must come first!
    local raw_context="$(kubectl config current-context 2>/dev/null)"
    local raw_pyenv="$(pyenv version-name)"
    local raw_host='\u@\h'
    local raw_path=$(pwd | sed -e "s|^${HOME}|~|" -re 's|([^/]{0,2})[^/]*/|\1/|g')
    local raw_branch=$(__git_ps1 '%s')

    if [[ "$raw_context" == "molly" ]]; then
        raw_context=
    fi

    if [[ "$raw_pyenv" == "$(pyenv global)" ]]; then
        raw_pyenv=
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
    local CONTEXT_FG=$gruvbox_white
    local PYENV_FG=$gruvbox_white
    local LOCAL_FG=$gruvbox_fg3
    local REMOTE_FG=$gruvbox_fg
    local PATH_FG=$gruvbox_gray
    local BRANCH_FG=$gruvbox_gray

    # Background colours.
    local STATUS_BG=$gruvbox_orange
    local CONTEXT_BG=$gruvbox_purple
    local PYENV_BG=$gruvbox_blue
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
    local pretty_context="\[\e[$FG$CONTEXT_FG;$BG${CONTEXT_BG}m\] $raw_context "
    local pretty_pyenv="\[\e[$FG$PYENV_FG;$BG${PYENV_BG}m\] $raw_pyenv "
    local pretty_host="\[\e[$FG$host_fg;$BG${host_bg}m\] $raw_host "
    local pretty_path="\[\e[$FG$PATH_FG;$BG${PATH_BG}m\] $raw_path "
    local pretty_branch="\[\e[$FG$BRANCH_FG;$BG${BRANCH_BG}m\] $raw_branch "

    if [[ -n $raw_context ]]; then
        local status_arrow_bg=$CONTEXT_BG
    elif [[ -n $raw_pyenv ]]; then
        local status_arrow_bg=$PYENV_BG
    else
        local status_arrow_bg=$host_bg
    fi

    if [[ -n $raw_pyenv ]]; then
        local context_arrow_bg=$PYENV_BG
    else
        local context_arrow_bg=$host_bg
    fi

    if [[ -n $raw_branch ]]; then
        local branch_arrow_fg=$BRANCH_BG
    else
        local branch_arrow_fg=$PATH_BG
    fi

    local status_arrow="\[\e[$FG$STATUS_BG;$BG${status_arrow_bg}m\]$ARROW"
    local context_arrow="\[\e[$FG$CONTEXT_BG;$BG${context_arrow_bg}m\]$ARROW"
    local pyenv_arrow="\[\e[$FG$PYENV_BG;$BG${host_bg}m\]$ARROW"
    local host_arrow="\[\e[$FG$host_bg;$BG${PATH_BG}m\]$ARROW"
    local path_arrow="\[\e[$FG$PATH_BG;$BG${BRANCH_BG}m\]$ARROW"
    local branch_arrow="\[\e[$FG${branch_arrow_fg}m\]$RESET_BG$ARROW"

    if [[ -z $raw_context ]]; then
        pretty_context=
        context_arrow=
    fi

    if [[ -z $raw_pyenv ]]; then
        pretty_pyenv=
        pyenv_arrow=
    fi

    if [[ $raw_status -eq 0 ]]; then
        pretty_status=
        status_arrow=
    fi

    if [[ -z $raw_branch ]]; then
        pretty_branch=
        path_arrow=
    fi

    PS1="$pretty_status$status_arrow$pretty_context$context_arrow"
    PS1="$PS1$pretty_pyenv$pyenv_arrow$pretty_host$host_arrow"
    PS1="$PS1$pretty_path$path_arrow$pretty_branch$branch_arrow$RESET "

    PS2="\[\e[$FG${gruvbox_gray};$BG${gruvbox_bg1}m\]...\[\e[$FG${gruvbox_bg1}m\]$RESET_BG$ARROW$RESET "
    PS3="\[\e[$FG${gruvbox_white};$BG${gruvbox_blue}m\] ${PS3:=Enter a number: }\[\e[$FG${gruvbox_blue}m\]$RESET_BG$ARROW$RESET "
    PS4="\[\e[$FG${gruvbox_white};$BG${gruvbox_blue}m\] $0:$LINENO \e[$FG${gruvbox_blue}m\]$RESET_BG$ARROW$RESET "

    # Set the window title.
    echo -n -e "\033]0;$raw_path\007"
}


# Load colour profile for ls.
if which dircolors &> /dev/null; then
    if [[ -r ~/.dircolors ]]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
fi


# Gimmicks.
if which fortune sed par &> /dev/null; then
    echo
    fortune | sed 's/^/  > /' | par 76
    echo
fi


# Run local config.
if [[ -f $HOME/.bashrc_local  ]]; then
    source "$HOME/.bashrc_local"
fi


# Exit cleanly.
true
