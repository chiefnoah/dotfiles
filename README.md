# dotfiles

***"you are your dotfiles."***

These are all my dotfiles for *nix. Some of them are specific to my [riced desktop setups](https://tildeslash.io/rice.html).


## Install/Uninstall

`git clone --recursive https://github.com/JoshuaRLi/dotfiles`, install `stow`, then simply execute `link.sh PRESET` to link dotfiles for the preset that you want (if you want to unlink, pass `d` as the second argument). Here are the current presets:

```
base        - basic configuration for non-graphical environment
baseg       - basic configuration for graphical environment, inherits base
rice_og     - configuration for Arch Linux rice "og", inherits base, baseg
tatami4.5   - config for Alpine Linux rice "tatami4.5"
```

Alternatively, you may consider using `stow` to cherry-pick and link individual dotfile folders of your choosing - `link.sh` is convenience.


### `.specificrc`

This file, sourced by `common/.commonrc`, defines shell aliases, functions and environment exports specific to the distribution and software I usually use with the distribution. `link.sh` will automatically `touch ~/.specificrc` when installing the base or baseg distro-agnostic preset - this prevents the error message that is displayed when attempting to source a nonexistent file.
