#!/bin/sh

urxvtd -q -f -o &
compton -bCG
sxhkd &
redshift &
dunst &
polybar top &
polybar bottom &
# udiskie -2 -s &

exec bspwm
