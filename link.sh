#!/usr/bin/env sh

die () { printf '%s\\n' "ERROR: ${1}"; exit 1; }

command -v stow > /dev/null 2>&1 || die 'You must have GNU stow installed.'

usage () {
    cat <<EOF
USAGE: $0 PRESET [d]

PRESETS:
base        - all non-graphical, non-dev configs
baseg       - all X/graphical configs
dev         - blanket development environment config
og          - config for Arch Linux rice "og"
tatami4.5   - config for Alpine Linux rice "tatami4.5"
work        - config for work [currently: sentry.io]

Pass d as the second argument if you want to unlink the dotfiles belonging
to the specified macro.
EOF
	exit 1
}

p_base="base bin mksh bash zsh tools"

if [ "$2" = 'd' ]; then
    stow="stow -vDt ${HOME}"
else
    stow="stow -vt ${HOME}"
fi

if
    ! case "$1" in
	base)
	    $stow $p_base
        $stow -d applications ranger weechat
        ;;
    baseg)
        $stow -d applications cava mpv redshift
        $stow -d dev-tools atom
        ;;
    dev)
        $stow -d dev-langs python golang rust ruby nodejs
        $stow -d dev-tools basics nano micro
        ;;
	og)
		$stow $p_base 'os-arch' 'rice-og'
        $stow -d applications ranger weechat \
            cava mpv redshift
        ;;
    tatami4.5)
		$stow $p_base 'os-alpine' 'rice-tatami4.5'
        $stow -d applications ranger weechat \
            mpv
        ;;
    work)
		$stow $p_base 'os-mac' 'rice-work'
        $stow -d applications weechat \
            mpv
        $stow -d dev-langs python nodejs
        $stow -d dev-tools basics nano micro
        ;;
	*)
		usage ;;
    esac
then
    die "stow exited unsuccessfully; you probably have to move or delete the files stow is conflicting with."
fi
