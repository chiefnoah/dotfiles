# dotfiles

***"you are your dotfiles."***

For a general list of software I use and recommend, refer to [essentials](https://github.com/JoshuaRLi/essentials).


### Install/Uninstall

Simply execute `link.sh base|arch|debian`. If you want to uninstall (unlink symlinks), pass `d` as the second argument. 

`link.sh base` should be used when there is no X server running; only tty access. It is a dotfiles subset for the other options.

Additionally, the `install-{distribution-name}.sh` scripts are useful to provision a fresh distribution install with the software that my dotfiles configure.

* `install-arch` assumes a fresh Arch install with nothing but tty access, which it turns into [this](https://github.com/JoshuaRLi/essentials/blob/master/README.md#arch-linux).
* `install-debian` assumes a fresh Debian install preconfigured with a functional desktop environment running on X.


### Special Directories

There are a few special directories worth noting.

* `arch/` - contains the `.specificrc` for arch-based distros as well as some X configuration
* `debian/` - contains the `.specificrc` for debian-based distros
* `common/` - contains common shell aliases, functions, environment, and more, for all distros
* `manual-configs/` - configuration files that require a more manual, involved installation process than merely symlinking
* `scripts/` - useful scripts that i've written


### `.specificrc`

This file, sourced by `common/.commonrc`, defines shell aliases, functions and environment exports specific to the distribution and software I usually use with the distribution.

If you are just installing the base dotfiles, it is useful to `touch ~/.specificrc` to prevent the error message that is displayed when attempting to source a nonexistent file.
