# Welcome $HOME (Linux)

These configuration files are for the GNU toolchain.

## Install

1.  Install some basic things:

    ```
    sudo apt-get update
    sudo apt-get install \
        curl \
        dos2unix \
        fortunes \
        git \
        httpie \
        i3 \
        i3lock \
        imagemagick \
        jq \
        neovim \
        playerctl \
        ripgrep \
        scrot \
        stow \
        tree
    ```

2.  Also install [vim-plug][], [universal-ctags][], [jeo][], and compile
    a keymap to put in `~/.config/xkb/keymap.xkm` for `loadkeys` to use.

3.  Clone this repo and use `stow` to link the relevant config into `$HOME`:

    ```bash
    cd && git clone git@github.com:ecridge/dotfiles.git -b linux
    cd dotfiles
    stow bash
    stow i3  # etc...
    ```

4.  Maybe cherry-pick some extra stuff from the [outdated] [wiki][].

[jeo]: https://github.com/ecridge/jeo
[universal-ctags]: https://github.com/universal-ctags/ctags
[vim-plug]: https://github.com/junegunn/vim-plug
[wiki]: https://github.com/ecridge/dotfiles/wiki
