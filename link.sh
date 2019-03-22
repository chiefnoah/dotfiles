#!/usr/bin/env sh

die () { printf %s\\n "ERROR: ${1}"; exit 1; }

command -v sym > /dev/null 2>&1 || die 'command sym not found'

usage () {
    cat <<EOF
USAGE: $0 PRESET [d]

PRESETS:
base        - base, bin, and interactive shell configs
og          - Arch Linux "og" configs
tatami      - Alpine Linux "tatami" configs
work        - configs for work [currently: n/a]

Pass d as the second argument if you want to unlink the dotfiles
belonging to the specified preset.
EOF
    exit 1
}

sym="sym -v"
[ "$2" = 'd' ] && sym="sym -dv"

if
    ! case "$1" in
    base)
        $sym base
        $sym bin
        $sym apps/gnupg
        $sym shells/zsh
        $sym shells/mksh
        $sym shells/bash
        ;;
    og)
        $sym base
        $sym bin
        $sym os/arch
        $sym configs/og
        $sym apps/gnupg
        $sym apps/cava
        $sym apps/redshift
        $sym apps/rofi-pass
        $sym dev-langs/python
        $sym dev-langs/golang
        $sym dev-langs/rust
        $sym dev-tools/editorconfig
        $sym dev-tools/git
        $sym dev-tools/nano
        $sym dev-tools/micro
        $sym dev-tools/tmux
        $sym shells/zsh
        ;;
    tatami)
        $sym base
        $sym bin
        $sym os/alpine
        $sym configs/tatami
        $sym apps/gnupg
        $sym dev-langs/python
        $sym dev-langs/golang
        $sym dev-langs/rust
        $sym dev-tools/editorconfig
        $sym dev-tools/git
        $sym dev-tools/nano
        $sym dev-tools/micro
        $sym dev-tools/tmux
        $sym shells/mksh
        ;;
    work)
        true
#        $sym base
#        $sym bin
#        $sym os/osx
#        $sym configs/work
#        $sym dev-langs/python
#        $sym dev-tools/editorconfig
#        $sym dev-tools/micro
#        $sym dev-tools/tmux
#        $sym shells/zsh
        ;;
    *)
        usage
        ;;
    esac
then
    die "sym exited unsuccessfully"
fi
