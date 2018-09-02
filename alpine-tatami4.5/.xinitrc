#!/bin/sh

urxvtd -q -f -o &
sxhkd &
dunst &

# TODO udisks2 + udiskie

exec bspwm
