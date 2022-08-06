Font comes from <https://github.com/powerline/fonts>.
Run `fc-cache -f ~/.local/share/fonts` after installing to add to index.

Terminal profiles can be loaded into an existing profile slot by UUID
(shown in the preferences panel) using `dconf`:

    dconf load "/org/gnome/terminal/legacy/profiles:/:$UUID/" < foo.profile

You can `dump` instead of load as you expect, or `list` the parent 'dir'.
The default profile doesn't exist in dconf until you make a change to it.
