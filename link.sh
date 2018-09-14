#!/usr/bin/env sh

die () { printf "%s\\n" "ERROR: ${1}"; exit 1; }

command -v stow > /dev/null 2>&1 || die 'You must have GNU stow installed.'

usage () {
    cat <<EOF
USAGE: $0 PRESET [d]

PRESETS:
base        - all non-graphical, non-dev configs
baseg       - all graphical, non-dev configs
dev         - blanket dev environment config
devg        - graphical dev tools
og          - config for Arch Linux rice "og"
tatami4.5   - config for Alpine Linux rice "tatami4.5"
work        - config for work [currently: yelp]

Pass d as the second argument if you want to unlink the dotfiles
belonging to the specified macro.
EOF
	exit 1
}

stow="stow -vt ${HOME}"
[ "$2" = 'd' ] && stow="stow -vDt ${HOME}"

if
    ! case "$1" in
	base)
	    $stow base bin
        $stow -d apps weechat gnupg cava
        $stow -d shells bash mksh zsh
        ;;
    baseg)
        $stow -d appsg mpv redshift rofi-pass
        ;;
    dev)
        $stow -d dev-langs python golang rust ruby nodejs
        $stow -d dev-tools editorconfig git nano micro tmux sqlite
        $stow -d shells bash mksh zsh
        ;;
    devg)
        $stow -d dev-tools atom
        ;;
	og)
		$stow base bin 'os-arch' 'rice-og'
        $stow -d apps weechat gnupg cava
        $stow -d appsg redshift rofi-pass
        $stow -d dev-langs python golang rust ruby nodejs
        $stow -d dev-tools editorconfig git nano micro tmux sqlite
        $stow -d shells zsh
        ;;
    tatami4.5)
		$stow base bin 'os-alpine' 'rice-tatami4.5'
        $stow -d apps weechat gnupg \
        $stow -d appsg mpv
        $stow -d dev-langs python golang rust ruby nodejs
        $stow -d dev-tools editorconfig git nano micro tmux
        $stow -d shells mksh
        ;;
    work)
		$stow --ignore='Brewfile' base bin 'os-mac' 'rice-work'
        $stow -d appsg mpv
        $stow -d dev-langs python
        $stow -d dev-tools editorconfig micro tmux
        $stow -d shells zsh
        ;;
	*)
		usage ;;
    esac
then
    die "stow exited unsuccessfully; you probably have to move or delete the files stow is conflicting with."
fi
