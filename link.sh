#!/usr/bin/env sh

die () { printf %s\\n "ERROR: ${1}"; exit 1; }

command -v stow > /dev/null 2>&1 || die 'You must have GNU stow installed.'

usage () {
    cat <<EOF
USAGE: $0 PRESET [d]

PRESETS:
base        - base, bin, and interactive shell configs
dd          - Arch Linux "dd" configs
tatami      - Alpine Linux "tatami" configs
work        - configs for work [currently: n/a]

Pass d as the second argument if you want to unlink the dotfiles
belonging to the specified preset.
EOF
    exit 1
}

stow="stow --no-folding -vt ${HOME}"
[ "$2" = 'd' ] && stow="stow -vDt ${HOME}"

if
    ! case "$1" in
    base)
        $stow base
        $stow --ignore='README\.md' --ignore='LICENSE' bin
        $stow -d apps gnupg
        $stow -d shells bash mksh zsh
        ;;
    dd)
        $stow base
        $stow --ignore='README\.md' --ignore='LICENSE' bin
        $stow -d os arch
        $stow -d configs dd
        $stow -d apps gnupg cava redshift rofi-pass irssi feh
        $stow -d dev-langs python golang rust ruby nodejs
        $stow -d dev-tools editorconfig git nano micro tmux sqlite
        $stow -d shells zsh
        ;;
    tatami)
        $stow base
        $stow --ignore='README\.md' --ignore='LICENSE' bin
        $stow -d os alpine
        $stow -d configs tatami
        $stow -d apps gnupg irssi feh
        $stow -d dev-langs python golang rust ruby nodejs
        $stow -d dev-tools editorconfig git nano micro tmux
        $stow -d shells mksh
        ;;
    work)
        true
#        $stow base
#        $stow --ignore='README\.md' --ignore='LICENSE' bin
#        $stow -d os osx
#        $stow -d apps irssi
#        $stow -d configs work
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
