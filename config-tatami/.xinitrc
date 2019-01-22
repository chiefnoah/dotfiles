#!/bin/sh

urxvtd -q -f -o &
sxhkd &
dunst &
feh --bg-center "${HOME}/wallpaper.png" &

[ -d "${HOME}/.local/share/fonts/tewi" ] && \
    xset +fp "${HOME}/.local/share/fonts/tewi"

exec bspwm
