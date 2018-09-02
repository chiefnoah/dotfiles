#!/usr/bin/env sh

if ! command -v stow > /dev/null 2>&1; then
    printf 'You must have GNU stow installed.\b'
    exit 1
fi

usage () {
    cat <<EOF
USAGE: $0 base|baseg|rice_og|rice_tatami4.5 [d]

base            - basic config for non-graphical environment
baseg           - basic config for graphical environment, inherits base
rice_og         - config for Arch Linux rice "og", inherits base, baseg
rice_tatami4.5  - config for Alpine Linux rice "tatami4.5"

Pass d as second arg if you want to unlink instead of link.
EOF
	exit 1
}

# configuration presets
p_base="common common-dev scripts bash zsh nano micro ranger"
p_baseg="atom mpv rofi redshift"
p_rice_og="arch-og bspwm-og sxhkd-og urxvt-og dunst-og polybar-og pywal-og"

if [ "$2" = 'd' ]; then
    stow_cmd="stow -vDt ${HOME}"
else
    stow_cmd="stow -vt ${HOME}"
fi

case "$1" in
	base)
        # see dotfiles README on why this is touched
        touch "${HOME}/.specificrc"
	    $stow_cmd $p_base
		;;
    baseg)
        touch "${HOME}/.specificrc"
        $stow_cmd $p_base $p_baseg
        ;;
	rice_og)
		$stow_cmd $p_base $p_baseg $p_rice_og
		;;
    rice_tatami4.5)
		$stow_cmd common common-dev scripts mksh nano micro ranger \
            alpine-tatami4.5 bspwm-tatami4.5 sxhkd-tatami4.5 urxvt-tatami4.5 \
            slstatus-tatami4.5 dmenu-tatami4.5 dunst-tatami4.5
		;;
	*)
		usage
		;;
esac

[ ! "$?" -eq 0 ] && printf "\nYou have to move or delete the files stow is conflicting with.\n"
