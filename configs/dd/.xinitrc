#!/bin/sh

urxvtd -q -f -o &
redshift &
udiskie -2 -s &
sxhkd &

# bspwm is in charge of loading colors into X, and starting polybar + dunst
exec bspwm
