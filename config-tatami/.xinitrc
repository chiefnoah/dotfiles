#!/bin/sh

urxvtd -q -f -o &
sxhkd &
dunst &
command -v udevil > /dev/null && \
command -v pmount > /dev/null && \
    devmon --sync \
    --exec-on-drive "notify-send \"volume %l (block device %f) mounted on %d\"" \
    --exec-on-unmount "notify-send \"volume %l (block device %f) unmounted from %d\"" \
    --exec-on-remove "notify-send \"block device %f removed\""

feh --bg-center "${HOME}/wallpaper.png" &

[ -d "${HOME}/.local/share/fonts/tewi" ] && \
    xset +fp "${HOME}/.local/share/fonts/tewi"

exec bspwm
