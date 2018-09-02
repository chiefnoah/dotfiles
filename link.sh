#!/usr/bin/env sh

die () { printf "ERROR: ${1}\n"; exit 1; }

usage () {
    cat <<EOF
USAGE: $0 PRESET [d]

PRESETS:
base        - basic config for non-graphical environment
baseg       - basic config for generic graphical environment, inherits base
og          - config for Arch Linux rice "og", inherits base, baseg
tatami4.5   - config for Alpine Linux rice "tatami4.5"
cash        - config for generic MacOS systems used at work (currently: sentry.io)

Pass d as the second argument if you want to unlink the dotfiles belonging
to the specified macro.
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
        touch "${HOME}/.specificrc"
	    $stow_cmd $p_base
		;;
    baseg)
        touch "${HOME}/.specificrc"
        $stow_cmd $p_base $p_baseg
        ;;
	og)
		$stow_cmd $p_base $p_baseg \
            arch-og bspwm-og sxhkd-og urxvt-og dunst-og polybar-og pywal-og
		;;
    tatami4.5)
		$stow_cmd common common-dev bin mksh nano micro ranger mpv cava \
            alpine-tatami4.5 bspwm-tatami4.5 sxhkd-tatami4.5 urxvt-tatami4.5 dunst-tatami4.5
		;;
    cash)
		$stow_cmd $p_base \
		;;
	*)
		usage ;;
esac

[ ! "$?" -eq 0 ] && \
    die "\nStow exited unsuccessfully. You likely have to move or delete the files stow is conflicting with."
