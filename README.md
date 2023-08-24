# Ubuntu Dotfiles

1. Ensure some basics are installed:

   ```
   sudo add-apt-repository ppa:maveonair/helix-editor
   sudo apt-get update
   sudo apt-get install \
       curl \
       feh \
       fortunes \
       git \
       helix \
       httpie \
       libghc-xmonad-contrib-dev \
       libghc-xmonad-dev \
       jq \
       pipx \
       python3-ipython \
       ripgrep \
       stow \
       suckless-tools \
       tree \
       xmobar \
       xmonad
   ```

2. Install [Rust](https://rustup.rs/), then use Cargo to install the latest release of
   [Alacritty](https://github.com/alacritty/alacritty]).  See `INSTALL.md` in the Alacritty repo (for that version tag)
   for the required system packages to install beforehand, and the post-install steps to run (once) after.

3. Create a new SSH key pair and add it to GitHub.

4. Clone this repo and use `stow` to link the relevant config into `$HOME`:

   ```bash
   cd && git clone git@github.com:ecridge/dotfiles.git
   cd dotfiles
   stow bash
   stow git  # etc...
   ```

5. Clone [jeo](https://github.com/ecridge/jeo), compile a Kinesis keymap, and copy or link it into
   `~/.config/xkb/keymap.xkm`.

6. Make a suitable `xrandr` command and put it as a Bash executable in `~/bin/fixdisplays`, e.g.

   ```bash
   #!/bin/bash
   xrandr \
       --output eDP-1 --auto --pos 0x1360 \
       --output HDMI-1-0 --auto --pos 1920x0 --rotate left \
       --output DP-1-0 --auto --pos 3360x420
   ```

7. Set a wallpaper (will be reloaded thereafter), e.g. `feh --bg-fill /usr/share/backgrounds/Some_Included_Image.png`.
