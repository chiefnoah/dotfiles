#!/bin/sh

urxvtd -q -f -o &
sxhkd &
redshift &
dunst &
udiskie -2 -s &

exec bspwm
