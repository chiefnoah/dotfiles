#!/usr/bin/env bash

for d in $(ls -d */)
do
    OUT="$(stow -v -D -t "$HOME" "$d" 2>&1)"
    UNLINKED="$(echo "$OUT" | grep -oP "(?<=UNLINK: )[^ ]+")"
    for DF in $UNLINKED
    do
        BACK="${HOME}/${DF}.stow-bak"
        if [[ -e "$BACK" ]]; then
            echo "Restoring backup ${BACK} -> ${BACK%.*}"
            mv "$BACK" "${BACK%.*}"
        fi
    done
done

echo "Success."
