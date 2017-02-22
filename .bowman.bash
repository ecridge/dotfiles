# Some useful fzf, fasd, and Bash functions.
# See <http://seanbowman.me/blog/fzf-fasd-and-bash-aliases/>.


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


# View known file with syntax highlighting.
v() {
    ftype=$(pygmentize -N "$1")
    pygmentize -l "$ftype"\
      -f terminal "$1" |\
        less -R
}
complete -f v


# Interactive find nested file, then view with syntax highlighting.
vv() {
    local file
    if [[ -e "$1" ]]; then
        v "$1"
    else
        file=$(fzf --query="$1"\
          --select-1 --exit-0)
        [ -n "$file" ] && v "$file"
    fi
}
complete -f vv


# Find nested file.
function ff () {
    find . -name "$@" ;
}
complete -f ff
