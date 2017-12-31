#!/bin/sh

urxvtd -q -f -o &
sxhkd &
redshift &
dunst &  # notify-send in bspwmrc's wal-set stalls forever if there is no initial dunst process running
polybar top &
polybar bottom &
# udiskie -2 -s &

exec bspwm  # bspwmrc calls my wal-set script, which starts compton
