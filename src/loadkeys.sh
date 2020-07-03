#!/usr/bin/env bash

xkbcomp ~/.config/xkb/keymap.xkm $DISPLAY
xinput --list \
    | grep -E 'Cooler Master|Logitech|Yubico' \
    | grep -Po '(?<=id=)[0-9]+' \
    | xargs -I device_id setxkbmap -device device_id us
