# dotfiles

***"you are your dotfiles."***

### Organization

`universal/` contains dotfiles and software configurations that should work across most gnu/linux distributions. Any other top level directory is `{distribution-name}/` and contains a `.specificrc` file, sourced by `universal/.commonrc`. That file defines shell aliases, functions and environment exports specific to the distribution or to software I usually use with the distro.

Each distro TLD is complemented with a `install-{distribution-name}.sh` initial bootstrapping script:

* `install-arch` assumes a fresh Arch install with nothing but tty access.
* `install-debian` assumes a fresh Debian install preconfigured with a functional desktop environment running on X.

Finally, `special/` contains configuration files that have a more individual, involved install process.


### Installation

These dotfiles are not universally plug-and-play; there are files that are specific to me, like `universal/.gitconfig`. That being said, here is an example installation on Arch:

```bash
DFDIR="${HOME}/dots"
git clone --recursive https://github.com/JoshuaRLi/dotfiles.git "$DFDIR" && cd "$DFDIR"
DISTRO='arch'
"./install-${DISTRO}.sh" && ./link.sh universal "$DISTRO"
```


### Special Directories

There are a few special directories worth noting.

* `arch/` - contains the `.specificrc` for arch-based distros
* `debian/` - contains the `.specificrc` for debian-based distros
* `common/` - contains common shell aliases, functions, environment, and more, for all distros
* `manual-configs/` - configuration files that require a more manual, involved installation process than merely symlinking
* `scripts/` - useful scripts that i've written


### Backup/Restore/Uninstall

If `link.sh` encounters existing dotfiles while creating symlinks, it will make backups suffixed with `.stow-bak`. To remove all dotfile symlinks, simply `unlink.sh` with no arguments. If there is an existing `.stow.bak` match, that file will be restored by removing the backup suffix.

**Important:** This backup/restore functionality has not been thoroughly tested; it is a poor hack that I threw together because GNU stow does not have this functionality built-in. I would advise to use caution with my linking and unlinking scripts.

TODO: I will be implementing my own symlinker soon, rather than rely on `stow`.


### Software

For a general list of software I use and recommend, refer to [essentials](https://github.com/JoshuaRLi/essentials).
