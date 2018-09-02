#!/bin/sh

urxvtd -q -f -o &
sxhkd &
dunst &
feh --bg-center "${HOME}/wallpaper.png" &

# TODO udisks2 + udiskie

exec bspwm
