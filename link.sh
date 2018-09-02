#!/usr/bin/env sh

die () { printf '%s\\n' "ERROR: ${1}"; exit 1; }

command -v stow > /dev/null 2>&1 || die 'You must have GNU stow installed.'

usage () {
    cat <<EOF
USAGE: $0 PRESET [d]

PRESETS:
base        - non-graphical, non-dev configs
baseg       - X/graphical configs
dev         - blanket development environment config
og          - config for Arch Linux rice "og"
tatami4.5   - config for Alpine Linux rice "tatami4.5"
work        - config for work [currently: sentry.io]

Pass d as the second argument if you want to unlink the dotfiles belonging
to the specified macro.
EOF
	exit 1
}

p_base="base bin mksh bash zsh ranger weechat tools"
p_baseg="mpv rofi redshift cava"

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
        $stow_cmd -d dev-tools atom
        $stow_cmd $p_baseg ;;
    dev)
        $stow_cmd -d dev-tools basics nano micro
        $stow_cmd -d dev-langs python golang rust ruby nodejs
        ;;
	og)
		$stow_cmd $p_base $p_baseg 'os-arch' 'rice-og' ;;
    tatami4.5)
		$stow_cmd $p_base $p_baseg 'os-alpine' 'rice-tatami4.5' ;;
    work)
		$stow_cmd $p_base $p_baseg 'os-mac' 'rice-work'
        $stow_cmd -d dev-tools basics nano micro
        $stow_cmd -d dev-langs python nodejs
        ;;
	*)
		usage ;;
    esac
then
    die "stow exited unsuccessfully; you probably have to move or delete the files stow is conflicting with."
fi
