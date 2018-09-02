#!/usr/bin/env sh

die () { printf '%s\\n' "ERROR: ${1}"; exit 1; }

command -v stow > /dev/null 2>&1 || die 'You must have GNU stow installed.'

usage () {
    cat <<EOF
USAGE: $0 PRESET [d]

PRESETS:
base        - basic config for non-graphical environment
baseg       - basic config for generic graphical environment [inherits base]
dev         - blanket development environment config
og          - config for Arch Linux rice "og" [inherits base, baseg]
tatami4.5   - config for Alpine Linux rice "tatami4.5"
cash        - config for generic MacOS systems used at work [currently: sentry.io]

Pass d as the second argument if you want to unlink the dotfiles belonging
to the specified macro.
EOF
	exit 1
}

p_base="base bin sh mksh bash zsh nano micro ranger weechat tools"
p_baseg="atom mpv rofi redshift cava"
p_dev="tools-dev python golang rust nodejs ruby"

if [ "$2" = 'd' ]; then
    stow_cmd="stow -vDt ${HOME}"
else
    stow_cmd="stow -vt ${HOME}"
fi

if
    ! case "$1" in
	base)
	    $stow_cmd $p_base ;;
    baseg)
        $stow_cmd $p_base $p_baseg ;;
    dev)
        $stow_cmd $p_dev ;;
	og)
		$stow_cmd $p_base $p_baseg \
            arch-og bspwm-og sxhkd-og urxvt-og dunst-og polybar-og pywal-og ;;
    tatami4.5)
		$stow_cmd $p_base $p_baseg \
            alpine-tatami4.5 bspwm-tatami4.5 sxhkd-tatami4.5 urxvt-tatami4.5 dunst-tatami4.5 ;;
    cash)
		$stow_cmd $p_base $p_baseg $p_dev \
            macos-cash ;;
	*)
		usage ;;
    esac
then
    die "stow exited unsuccessfully; you probably have to move or delete the files stow is conflicting with."
fi
