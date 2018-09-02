#!/usr/bin/env zsh

ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="gianu"

# load oh-my-zsh default configuration and clear all aliases
. "${ZSH}/oh-my-zsh.sh"
unalias -m "*"

# bring in common shell aliases, environment and functions
. "${HOME}/.shlib"
. "${HOME}/.commonrc"

autoload -Uz compinit

globalias () {
   zle _expand_alias
   zle expand-word
   zle self-insert
}

zle -N globalias
bindkey " " globalias
bindkey "^ " magic-space            # control-space to bypass completion
bindkey -M isearch " " magic-space  # normal space during history searches

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
setopt COMPLETE_IN_WORD
setopt PATH_DIRS
unsetopt CASE_GLOB
setopt AUTO_CD
setopt NULL_GLOB

# history
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
