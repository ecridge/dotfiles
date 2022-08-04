# Welcome $HOME (Linux)

These configuration files are for the GNU toolchain.

## Install

1.  Clone and use `stow` to link the relevant config into `$HOME`:

    ```bash
    cd && git clone git@github.com:joecridge/dotfiles.git -b linux
    cd dotfiles
    stow bash
    stow i3  # etc...
    ```

2.  Install the dependencies listed on the [wiki][].

[wiki]: https://github.com/joecridge/dotfiles/wiki
