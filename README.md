# dotfiles

***"you are your dotfiles."***

These are all my dotfiles for gnu/linux. Some of them are rice-specific - check out my ricing work [here](https://tildeslash.io/rice.html).


### Install/Uninstall

`git clone --recursive https://github.com/JoshuaRLi/dotfiles`, install `stow`, then simply execute `link.sh PRESET` to link dotfiles for the preset that you want. Here are the current presets:

```
base        - basic configuration for non-graphical environment
baseg       - basic configuration for graphical environment, inherits base
rice_og     - configuration for Arch Linux rice "og", inherits base, baseg
tatami4.5   - config for Alpine Linux rice "tatami4.5"
```

Alternatively, you may consider using `stow` to cherry-pick and link individual dotfile folders of your choosing - `link.sh` is convenience.

If you want to unlink (effectively uninstalling a dotfiles preset), pass `d` as the second argument.


#### Special Directories

There are a few special directories worth noting.

* `common/` - contains common shell aliases, functions, environment, and more, for all distros
* `manual-configs/` - configuration files that require a more manual, involved installation process than merely symlinking
* `scripts/` - useful scripts that i've written


#### `.specificrc`

This file, sourced by `common/.commonrc`, defines shell aliases, functions and environment exports specific to the distribution and software I usually use with the distribution. `link.sh` will automatically `touch ~/.specificrc` when installing the base or baseg distro-agnostic preset - this prevents the error message that is displayed when attempting to source a nonexistent file.
