#!/bin/sh

urxvtd -q -f -o &
sxhkd &
dunst &
feh --bg-center "${HOME}/wallpaper.png" &

# TODO udisks2 + udiskie

[ -d "${HOME}/.local/share/fonts" ] && \
    xset +fp "${HOME}/.local/share/fonts"

exec bspwm
