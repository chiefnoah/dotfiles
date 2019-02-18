#!/usr/bin/env sh

die () { printf %s\\n "ERROR: ${1}"; exit 1; }

command -v stow > /dev/null 2>&1 || die 'You must have GNU stow installed.'

usage () {
    cat <<EOF
USAGE: $0 PRESET [d]

PRESETS:
base        - base, bin, and interactive shell configs
ng          - all non-graphical, non-dev configs
g           - all graphical, non-dev configs
dev         - blanket dev environment configs
devg        - graphical dev tools
og          - Arch Linux "og" configs
tatami      - Alpine Linux "tatami" configs
work        - configs for work [currently: n/a]

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
        $stow -d apps gnupg
        $stow -d shells bash mksh zsh
        ;;
    ng)
        $stow -d apps cava
        ;;
    g)
        $stow -d appsg redshift rofi-pass
        ;;
    dev)
        $stow -d dev-langs python golang rust ruby nodejs
        $stow -d dev-tools editorconfig git nano micro tmux sqlite
        $stow -d shells bash mksh zsh
        ;;
    devg)
#        $stow -d dev-tools ...
        true
        ;;
    og)
        $stow base bin 'os-arch' 'config-og'
        $stow -d apps gnupg cava
        $stow -d appsg redshift rofi-pass
        $stow -d dev-langs python golang rust ruby nodejs
        $stow -d dev-tools editorconfig git nano micro tmux sqlite
        $stow -d shells zsh
        ;;
    tatami)
        $stow base bin 'os-alpine' 'config-tatami'
        $stow -d apps gnupg
        $stow -d dev-langs python golang rust ruby nodejs
        $stow -d dev-tools editorconfig git nano micro tmux
        $stow -d shells mksh
        ;;
    work)
        true
#        $stow --ignore='Brewfile' base bin 'os-mac' 'config-work'
#        $stow -d dev-langs python
#        $stow -d dev-tools editorconfig micro tmux
#        $stow -d shells zsh
        ;;
    *)
        usage
        ;;
    esac
then
    die "stow exited unsuccessfully; you probably have to move or delete the files stow is conflicting with."
fi
