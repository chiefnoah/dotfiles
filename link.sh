#!/usr/bin/env sh

die () { printf "ERROR: ${1}\n"; exit 1; }

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

command -v stow > /dev/null 2>&1 || die 'You must have GNU stow installed.'

# configuration presets
p_base="common common-dev bin bash zsh nano micro ranger"
p_baseg="atom mpv rofi redshift cava"

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
		$stow_cmd $p_base $p_baseg \
            arch-og bspwm-og sxhkd-og urxvt-og dunst-og polybar-og pywal-og
		;;
    rice_tatami4.5)
		$stow_cmd common common-dev bin mksh nano micro ranger mpv cava \
            alpine-tatami4.5 bspwm-tatami4.5 sxhkd-tatami4.5 urxvt-tatami4.5 dunst-tatami4.5
		;;
	*)
		usage ;;
esac

[ ! "$?" -eq 0 ] && \
    die "\nStow exited unsuccessfully. You likely have to move or delete the files stow is conflicting with."
