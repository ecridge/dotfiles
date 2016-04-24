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
gumpf+='*.xccheckout|*.xcscmblueprint|.git|node_modules|typings'


# Set aliases.
alias ag='ag -s'  # Case-sensitive by default.
alias aq='ag -Q'  # Match literals instead of regexen.
alias b=brew
alias ascii="ag '[^ -~\\n]'"  # Highlight non-ASCII characters in a file.
alias c=clear
alias chdom=chmod  # Common typo.
alias chrome='open -a /Applications/Google\ Chrome.app/'
alias bundel=bundle  # Another typo.
alias dr=docker
alias e=nvim
alias electron=node_modules/.bin/electron
alias get="curl -sSi -X GET -H 'Accept: application/json'"
alias grep='grep --color=auto --exclude-dir=.git'
alias h=help
alias l='ls --color=auto'
alias la='l -A'
alias ll=$'l -AhFl --time-style=\'+%Y-%m-%d %H:%M\n%a %d %b %H:%M\''
alias m=man
alias mdl='mdl --style ~/.mdstyle'
alias n=npm
alias o=open
alias post="curl -sSi -X POST -H 'Content-type: application/json' -d"
alias printenv="printenv | sort | grep -Pe '^[A-Z][A-Z0-9_]*(?==)'"
alias put="curl -sSi -X PUT -H 'Content-type: application/json' -d"
alias py='clear && python'
alias sudoa='sudo '  # An alias of sudo that expands aliases.
alias q=logout
alias t="tree -I \"$gumpf\""
alias vi=nvim
alias vim=nvim
alias vimdiff='nvim -d'
alias vd=vimdiff
alias vim="/cygdrive/c/Program\ Files\ \(x86\)/vim/vim73/gvim.exe -u 'C:\Program Files (x86)\vim\_vimrc'"

# Function to load Beyond Compare from the command line.
bc() {
  "/cygdrive/c/Program Files (x86)/Beyond Compare 4/BCompare.exe" $1 $2 -fv "Beyond Compare"
}


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
if which rbenv &> /dev/null; then eval "$(rbenv init -)"; fi
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"
[[ -f $HOME/.git-completion.bash ]] && source "$HOME/.git-completion.bash"
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
[[ -f $HOME/.bowman.bash ]] && source "$HOME/.bowman.bash"
eval "$(fasd --init auto)"


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


# Exit cleanly.
true
