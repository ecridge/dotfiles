#!/bin/bash
eval `gnome-keyring-daemon`
gnome-settings-daemon &
exec /usr/bin/i3
