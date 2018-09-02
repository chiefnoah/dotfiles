#!/bin/sh

urxvtd -q -f -o &
sxhkd &
dunst &

# TODO lemonbar + bin script
# TODO udisks2 + udiskie

exec bspwm
