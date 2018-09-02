# dotfiles

These are all my dotfiles for *nix.


## Install/Uninstall

`git clone --recursive https://github.com/JoshuaRLi/dotfiles`, install `stow`, then simply execute `link.sh PRESET` to link dotfiles for the preset that you want (if you want to unlink, pass `d` as the second argument). Here are the current presets:

```
base        - basic configuration for non-graphical environment
baseg       - basic configuration for graphical environment, inherits base
rice_og     - configuration for Arch Linux rice "og", inherits base, baseg
tatami4.5   - config for Alpine Linux rice "tatami4.5"
```

Alternatively, consider using `stow` to cherry-pick and link individual dotfile folders of your choosing - `link.sh` is just macro convenience.


### `.specificrc`

This file, sourced by `common/.commonrc`, defines shell aliases, functions and environment exports specific to the *nix distribution and software I usually use it such as package managers. `link.sh` will automatically `touch ~/.specificrc` when installing the base or baseg distro-agnostic preset - this prevents the error message that is displayed when attempting to source a nonexistent file.
