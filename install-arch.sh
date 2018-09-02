#!/usr/bin/env bash

set -e

CYANBOLD='\033[1;36m'
NOCOLOR='\033[0m'

notify () {
    printf "\n${CYANBOLD}${1}${NOCOLOR}\n\n"
}

notify "Updating git submodules..."
git submodule update --recursive --remote

notify "Updating system..."
sudo pacman -Syu

notify "Installing essential software..."
sudo pacman --noconfirm -S base-devel \
    cryptsetup curl dfc git gnupg2 htop nano ncdu openssh stow wget

# TODO switch to yay or trizen in the future
if ! command -v pacaur > /dev/null 2>&1; then
    notify "Installing pacaur..."
    # Automatically install pacaur: cower.
    cd "$TMP"
    mkdir cower && cd cower
    gpg2 --recv-keys 1EB2638FF56C0C53
    curl "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower" -o PKGBUILD
    . "/etc/profile.d/perlbin.sh"
    makepkg -si

    # Automatically install pacaur: pacaur.
    cd "$TMP"
    mkdir pacaur && cd pacaur
    curl https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur -o PKGBUILD
    makepkg -si
fi

notify "Installing zsh as login shell..."
sudo pacman --noconfirm -S zsh
sudo chsh -s "$(which zsh)" "$(whoami)"

notify "Done."
