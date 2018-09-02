# dotfiles

all my *nix configurations.


## Install/Uninstall

`git clone --recursive https://github.com/JoshuaRLi/dotfiles`, install `stow`, then simply execute `link.sh PRESET` to link dotfiles for the preset that you want (if you want to unlink, pass `d` as the second argument). Here are the current presets:

```
base        - basic config for non-graphical environment
baseg       - basic config for generic graphical environment, inherits base
dev         - blanket config for all development environments
og          - config for Arch Linux rice "og", inherits base, baseg
tatami4.5   - config for Alpine Linux rice "tatami4.5"
cash        - config for generic MacOS systems used at work (currently: sentry.io)
```
