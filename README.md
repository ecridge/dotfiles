# Welcome $HOME (OS X)

These configuration files are for the GNU toolchain, rather than the default
BSD toolchain that comes with OS X. These are easily replaced using
[Homebrew][] – see [this Gist][gist] from <https://www.topbug.net/>.

## Install

1.  Clone and unpack:

    ```bash
    cd && git clone -n git@github.com:joecridge/dotfiles.git -b darwin
    mv dotfiles/.git . && rmdir dotfiles
    git reset --hard HEAD  # Caution: existing dotfiles will be overwritten!
    ```

2.  Install the dependencies listed on the [wiki][].

3.  Hide this file and the user binaries from Finder:

    ```bash
    chflags hidden README.md bin resources
    ```

[Homebrew]: http://brew.sh/
[gist]: https://gist.github.com/xuhdev/8b1b16fb802f6870729038ce3789568f
[wiki]: https://github.com/joecridge/dotfiles/wiki
[xuhdev]: https://github.com/xuhdev
