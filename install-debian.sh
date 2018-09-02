#!/usr/bin/env bash

set -e
HERE="$(dirname "$(readlink -f "$0")")"
TMP="$(mktemp -d)"

cleanup () {
    rm -rf "$TMP"
}

trap cleanup EXIT

CYANBOLD='\033[1;36m'
YELLOWBOLD='\033[1;33m'
NOCOLOR='\033[0m'

notify () {
    printf "\n${CYANBOLD}${1}${NOCOLOR}\n\n"
}

ask () {
    while true; do
        printf "\n${YELLOWBOLD}${1} [y/n]: ${NOCOLOR}"
        read -r response
        case $response in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;
        esac
    done
}

notify "Updating..."
sudo apt update && sudo apt upgrade -y

notify "Updating submodules..."
cd "$HERE"
git submodule update --recursive --remote
mkdir -p "${HOME}/bin"

apti='sudo apt install -y'
notify "Installing software..."
$apti cryptsetup gnupg2 ssh \
    editorconfig fonts-hack-ttf \
    git stow \
    htop ncdu neofetch \
    maim \
    mpv \
    rofi \
    curl wget \
    xclip

if ask "Install python?"; then
    # TODO custom install pyenv
    $apti python3 python3-pip
fi

if ask "Custom install atom 1.22.1?"; then
    curl -Lo "${TMP}/atom.deb" https://github.com/atom/atom/releases/download/v1.22.1/atom-amd64.deb
    $apti gconf2 gconf-service gconf2-common libgconf-2-4
    sudo dpkg -i "${TMP}/atom.deb"
    apm install package-sync
    printf 'Use package-sync inside Atom to install from ~/.atom/packages.cson\n'
fi

if ask "Custom install micro 1.3.4?"; then
    curl -Lo "${TMP}/micro.tgz" https://github.com/zyedidia/micro/releases/download/v1.3.4/micro-1.3.4-linux64.tar.gz
    tar xfz "${TMP}/micro.tgz" -C "$TMP"
    mv -v "${TMP}/micro-1.3.4/micro" "${HOME}/bin"
fi

notify "Cleaning up..."
sudo apt autoremove -y

notify "Installing zsh and changing the login shell..."
$apti zsh
sudo chsh -s "$(which zsh)" "$(whoami)"
exec zsh
