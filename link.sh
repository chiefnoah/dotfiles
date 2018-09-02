#!/usr/bin/env sh

usage () {
	printf "USAGE: $0 base|baseg|debian|rice_og\n"
	exit 1
}

# dotfile presets
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
	    $stow_cmd $p_base
		;;
    baseg)
        $stow_cmd $p_base $p_baseg
        ;;
	rice_og)
		$stow_cmd $p_base $p_baseg $p_rice_og
		;;
	*)
		usage
		;;
esac

[ ! "$?" -eq 0 ] && printf "\nYou have to move or delete the files stow is conflicting with.\n"
