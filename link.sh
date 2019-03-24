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
        $sym \
            base        \
            bin         \
            apps/gnupg  \
            shells/zsh  \
            shells/mksh \
            shells/bash ;;
    og)
        $sym \
            base                    \
            bin                     \
            os/arch                 \
            configs/og              \
            apps/gnupg              \
            apps/cava               \
            apps/redshift           \
            apps/rofi-pass          \
            dev-langs/python        \
            dev-langs/golang        \
            dev-langs/rust          \
            dev-tools/editorconfig  \
            dev-tools/git           \
            dev-tools/nano          \
            dev-tools/micro         \
            dev-tools/tmux          \
            shells/zsh              ;;
    tatami)
        $sym \
            base                    \
            bin                     \
            os/alpine               \
            configs/tatami          \
            apps/gnupg              \
            dev-langs/python        \
            dev-langs/golang        \
            dev-langs/rust          \
            dev-tools/editorconfig  \
            dev-tools/git           \
            dev-tools/nano          \
            dev-tools/micro         \
            dev-tools/tmux          \
            shells/mksh             ;;
    work)
        true ;;
#        $sym \
#            base                    \
#            bin                     \
#            os/osx                  \
#            configs/work            \
#            dev-langs/python        \
#            dev-tools/editorconfig  \
#            dev-tools/git           \
#            dev-tools/nano          \
#            dev-tools/micro         \
#            dev-tools/tmux          \
#            shells/zsh             ;;
    *)
        usage
        ;;
    esac
then
    die "sym exited unsuccessfully"
fi
