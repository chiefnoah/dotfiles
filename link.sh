#!/usr/bin/env bash

[[ ! "$@" ]] && exit

HERE="$(dirname "$(readlink -f "$0")")"

(
cd "$HERE"
for dotdir in "$@"; do
    echo "LINKING ${dotdir}"
    if [[ -d "$dotdir" ]]; then
        # stow will refuse to link dotfiles in a directory if at least
        # one dotfile already exists, and there is no option to backup
        # clobbered dotfiles, so I made my own.
        OUT="$(stow --ignore='(bin|.gitmodules|VERSION)' -v -t "$HOME" "$dotdir" 2>&1)"
        if [[ $? -eq 1 ]]; then
            BADFILES="$(echo "$OUT" | grep -oP \
                "(?<=existing target is neither a link nor a directory: )[^ ]+")"
            for BADFILE in $BADFILES
            do
                echo "Backing up existing dotfile: ${HOME}/${BADFILE} -> ${HOME}/${BADFILE}.stow-bak"
                mv "${HOME}/${BADFILE}" "${HOME}/${BADFILE}.stow-bak"
            done
            # retry stowing, it should work now.
            # maybe there will be race conditions with nested dotfile directories...
            # I haven't tested this yet.
            set -e
            stow --ignore='(bin|.gitmodules|VERSION)' -v -t "$HOME" "$dotdir" > /dev/null 2>&1
            set +e
        fi
        echo "Success."
    else
        echo "directory ${dotdir} does not exist. skipping."
    fi
done
)

exec zsh
