#!/usr/bin/env sh

usage () {
	printf "USAGE: $0 base|arch|debian\n"
	exit 1
}

base_dots="common scripts bash zsh nano micro redshift ranger"
baseg_dots="atom mpv rofi"
arch_dots="arch bspwm sxhkd urxvt dunst polybar pywal"
debian_dots="debian"

if [ "$2" = 'd' ]; then
    stow_cmd="stow -vDt ${HOME}"
else
    stow_cmd="stow -vt ${HOME}"
fi

case "$1" in
	base)
	    $stow_cmd $base_dots
		;;
	arch)
		$stow_cmd $base_dots $baseg_dots $arch_dots
		;;
	debian)
		$stow_cmd $base_dots $baseg_dots $debian_dots
		;;
	*)
		usage
		;;
esac

[ ! "$?" -eq 0 ] && printf "You have to move or delete the files stow is conflicting with.\n"
