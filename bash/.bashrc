# Non-login Bash shells start here (only env vars are inherited from parent).

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
gumpf+='coverage_report|htmlcov|_site|*.tu|*.tu-*|env|target|'
gumpf+='CMakeLists.txt.user|CMakeCache.txt|CMakeFiles|CMakeScripts|Testing|'
gumpf+='Makefile|cmake_install.cmake|install_manifest.txt|compile_commands.json|'
gumpf+='CTestTestfile.cmake|_deps'

alias c=clear
alias diff='diff --color=auto'
alias dr=docker
alias e=nvim
alias grep='grep --color=auto --exclude-dir=.git'
alias jq='jq --indent 4'
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


eval "$(starship init bash)"
