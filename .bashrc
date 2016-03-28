[[ $- == *i* ]] || return 0  # Guard against non-interactive shells

# Customise command prompt
[[ -f "$HOME/.git-prompt.sh" ]] && source "$HOME/.git-prompt.sh"
PROMPT_COMMAND="custom_prompt"
custom_prompt() {
  exit_code=$?
  message_string=""
  bash_version=$(echo $BASH_VERSION | sed -e 's/\([0-9.]*\)(.*/\1/')
  swd=$(pwd | sed -e "s|^${HOME}|~|" -re 's|([^/]{0,2})[^/]*/|\1/|g')
  window_title="Bash $bash_version"
  if [ $exit_code -ne 0 ] ; then
    message_string="\[\e[31m\]exit $exit_code\[\e[0m\]\n"
  fi
  PS1="$message_string\u@\h:${swd}\[\e[32m\]\$(__git_ps1 "[%s]")\[\e[0m\]\$ "
  echo -n -e "\033]0;$window_title\007"
}

# Set aliases
alias ascii="grep -ne '[^ -~]'"  # Highlight non-ascii characters in a file
alias clr="clear"
alias chdom="chmod"
alias chrome="open -a /Applications/Google\ Chrome.app/"
alias bundel="bundle"
alias grep="grep --color=auto --exclude-dir=.git"
alias ls="ls --color=auto"
alias la="ls -A"
alias ll="ls -AhFl --time-style='+%Y-%m-%d %H:%M
%a %d %b %H:%M'"
alias mdl="mdl --style ~/.mdstyle"
alias printenv="printenv | sort | grep -Pe '^[A-Z][A-Z0-9_]*(?==)'"
alias py="clear && python"
alias sudoa="sudo "  # Create an alias of sudo that expands aliases
alias q="logout"
alias tree="tree -I '.DS_Store|.AppleDouble|.LSOverride|._*|.DocumentRevisions\
-V100|.fseventd|.Spotlight-V100|.TemporaryItems|.Trashes|.VolumeIcon.icns|.App\
leDB|.AppleDesktop|Network Trash Folder|Temporary Items|.apdisk|.localized|[._\
]*.?s[a-w][a-z]|Session.vim.netrwhist|*~|tags|node_modules|.git'"
alias vd="vimdiff"

# Function to make a new directory and change into it
mkcd() {
  mkdir "$@" && cd "$_"
}

# Function to make a new directory with a memorable name
temp() {
  SRC="$HOME/resources"
  if [[ -f "$SRC/adjectives" && -f "$SRC/animals" ]]; then
    iAdj=$RANDOM
    nAdj=`grep -c "." $SRC/adjectives`
    let "iAdj %= $nAdj"
    iAml=$RANDOM
    nAml=`grep -c "." $SRC/animals`
    let "iAml %= $nAml"
    (( iAdj++, iAml++ ))
    NAME=`sed -n "$iAdj p" $SRC/adjectives`-`sed -n "$iAml p" $SRC/animals`
    mkdir -vm 700 $NAME
  else
    mktemp -dp . temp-XXXX
  fi
}

# Run login items
binsync > /dev/null

# Other things that need loading
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
[[ -f "$HOME/.git-completion.bash" ]] && source "$HOME/.git-completion.bash"
[[ -f "$HOME/.hhighlight.sh" ]] && source "$HOME/.hhighlight.sh"
