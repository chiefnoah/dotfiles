This directory contains configuration files that require setup beyond the usual symlinking.


### gnome-settings

For GNOME 3 on Debian Stable.

Update: `dconf dump / | gpg -c > gnome-settings`

Install: `gpg2 -d gnome-settings | dconf load /`
