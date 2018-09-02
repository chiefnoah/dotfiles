#!/bin/sh

urxvtd -q -f -o &
sxhkd &
dunst &

# TODO lemonbar + slstatus
# TODO udisks2 + udiskie

exec bspwm
