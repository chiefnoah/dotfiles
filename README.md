# dotfiles

***"you are your dotfiles."***

For a general list of software I use and recommend, refer to [essentials](https://github.com/JoshuaRLi/essentials). See also: rice (todo).


### Install/Uninstall

`git clone --recursive https://github.com/JoshuaRLi/dotfiles`, install `stow`, then simply execute `link.sh PRESET` to link dotfiles for the preset that you want. Here are the current presets:

```
base    - basic configuration for non-graphical environment
baseg   - basic configuration for graphical environment, inherits base
rice_og - configuration for Arch Linux rice "og", inherits base, baseg
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
