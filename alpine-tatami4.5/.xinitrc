#!/bin/sh

urxvtd -q -f -o &
sxhkd &
dunst &

# TODO slstatus
# TODO udisks2 + udiskie

exec bspwm
