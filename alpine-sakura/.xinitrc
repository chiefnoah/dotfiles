#!/bin/sh

urxvtd -q -f -o &
compton -bCG
sxhkd &
redshift &
dunst &
polybar top &
polybar bottom &

if pacman -Qi udisks2 > /dev/null 2>&1 && \
   command -v udiskie > /dev/null 2>&1; then
    udiskie -2 -s &
fi

exec bspwm
