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
sudo pacman -Syu

notify "Installing base software..."
sudo pacman --noconfirm -S base-devel \
    cmake cryptsetup curl git gnupg2 htop ncdu openssh stow wget xorg-xinit xorg-server

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

notify "Updating submodules..."
cd "$HERE"
git submodule update --recursive --remote
mkdir -p "${HOME}/bin"

paci='pacaur --noedit --noconfirm -S'

notify "Installing software..."
$paci bspwm compton sxhkd polybar rofi rxvt-unicode ttf-font-awesome ttf-hack \
    dunst libnotify \
    python-pywal feh neofetch \
    editorconfig-core-c micro-bin \
    ranger highlight w3m \
    light-git redshift-minimal \
    maim \
    mpv \
    sxiv \
    xclip

notify "Installing physlock..."
$paci physlock
sudo bash -c "cat > /etc/systemd/system/physlock.service <<EOF
[Unit]
Description=Lock X session with physlock
Before=sleep.target

[Service]
Type=forking
ExecStart=/usr/local/bin/physlock -dsp 'This computer is locked.'

[Install]
WantedBy=sleep.target
EOF"
sudo systemctl enable /etc/systemd/system/physlock.service

if ask "Install python?"; then
    $paci python3 python-pip pyenv flake8
fi

if ask "Install rust?"; then
    $paci rustup
    rustup update stable
    rustup self upgrade-data
fi

if ask "Install golang?"; then
    $paci go go-tools
fi

if ask "Install atom?"; then
    $paci atom
    apm install package-sync
    printf 'Use package-sync inside Atom to install from ~/.atom/packages.cson\n'
fi

if ask "Install additional fonts?"; then
    $paci adobe-source-han-sans-otc-fonts \
        ttf-msfonts \
        ttf-symbola \
        ttf-unifont
fi

notify "Installing wallpapers..."
$paci imgp
git clone https://github.com/JoshuaRLi/papes "${HOME}/Wallpapers"
printf 'Screen width in pixels: ' ; read swidth
printf 'Screen height in pixels: ' ; read sheight
notify "Processing wallpapers."
cd "$HOME"
bash "${HERE}/scripts/bin/scripts/wallcrunch" \
    "${HOME}/Wallpapers" "$swidth" "$sheight"

notify "Installing zsh and changing the login shell..."
$paci zsh
sudo chsh -s "$(which zsh)" "$(whoami)"
exec zsh
