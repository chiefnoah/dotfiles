#!/usr/bin/env sh

usage () {
	printf "USAGE: $0 base|arch|debian\n"
	exit 1
}

base_dots="common scripts bash zsh nano micro redshift ranger"
baseg_dots="atom mpv rofi x"
arch_dots="arch bspwm sxhkd urxvt dunst compton polybar pywal"
debian_dots="debian"

case "$1" in
base)
	stow -vt "$HOME" $base_dots
	;;
arch)
	stow -vt "$HOME" $base_dots $baseg_dots $arch_dots
	;;
debian)
	stow -vt "$HOME" $base_dots $baseg_dots $debian_dots
	;;
*)
	usage
	;;
esac
