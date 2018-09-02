#!/bin/sh

urxvtd -q -f -o &
sxhkd &
# dunst & TODO
# TODO slstatus

# TODO udisks2 (and maybe udiskie)

exec bspwm
