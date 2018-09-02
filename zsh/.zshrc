#!/usr/bin/env zsh

ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="gianu"
plugins=(globalias wd colored-man-pages)

# Load oh-my-zsh default configuration.
. "${ZSH}/oh-my-zsh.sh"

# Clear all aliases to remove default zsh aliases.
unalias -m "*"

# Source common (bash compatible, and therefore zsh) shell aliases, environment and functions.
. "${HOME}/.commonrc"

autoload -Uz compinit

# oh-my-zsh default overrides (or not, I haven't checked).
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
setopt COMPLETE_IN_WORD
setopt PATH_DIRS
unsetopt CASE_GLOB
setopt AUTO_CD
setopt NULL_GLOB

# History configuration.
alias history='fc -l'
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST="$HISTSIZE"
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:ls:history"
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
