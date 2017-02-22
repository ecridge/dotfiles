# Some useful fzf, fasd, and Bash functions.
# See <http://seanbowman.me/blog/fzf-fasd-and-bash-aliases/>.


# Bash completion for aliases.
complete -F _fzf_path_completion -o default -o bashdefault ag
complete -F _fzf_file_completion -o default -o bashdefault chrome
complete -F _fzf_file_completion -o default -o bashdefault e
complete -F _fzf_dir_completion -o default -o bashdefault electron
complete -F _fzf_file_completion -o default -o bashdefault l
complete -F _fzf_file_completion -o default -o bashdefault la
complete -F _fzf_file_completion -o default -o bashdefault ll
complete -F _fzf_file_completion -o default -o bashdefault me
complete -F _fzf_path_completion -o default -o bashdefault o
complete -F _fzf_dir_completion -o default -o bashdefault t
complete -F _fzf_file_completion -o default -o bashdefault vd


# Go to frecent directory.
g() {
    local dir="$(fasd -ld "$@")"
    [[ -d "$dir" ]] && pushd "$dir" > /dev/null
}
complete -d g


# Interactive go to frecent directory.
gg() {
    local dir
    dir=$(fasd -Rdl |\
        sed "s:$HOME:~:" |\
        fzf --no-sort +m -q "$*" |\
        sed "s:~:$HOME:")\
    && pushd "$dir" > /dev/null
}
complete -d gg


# Interactive go to nested directory (based on directory name).
gd() {
    local dir
    dir=$(find ${1:-*} -path '*/\.*'\
        -prune -o -type d\
        -print 2> /dev/null | fzf +m)
    [ -d "$dir" ] && pushd "$dir" > /dev/null
}
complete -d gd


# Interactive go to nested directory (based on file name).
gf() {
    local file
    local dir
    file=$(fzf +m -q "$1")\
        && dir=$(dirname "$file")
    [ -d "$dir" ] && pushd "$dir" > /dev/null
}
complete -f gf


# View file with syntax highlighting.
v() {
    ftype=$(pygmentize -N "$1")
    pygmentize -l "$ftype"\
      -f terminal "$1" |\
        less -R
}
complete -f v
complete -F _fzf_file_completion -o default -o bashdefault v


# Find nested file.
function ff () {
    find . -name "$@" ;
}
complete -f ff
