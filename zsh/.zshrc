#!/usr/bin/env zsh

# bring in common shell aliases, environment and functions
. "${HOME}/.shlib"
. "${HOME}/.commonrc"

# prompt
setopt prompt_subst
shlib_export_PS1

# auto-expand aliases inline
globalias () {
   zle _expand_alias
   zle expand-word
   zle self-insert
}
zle -N globalias
bindkey " " globalias
bindkey "^ " magic-space            # control-space to bypass completion
bindkey -M isearch " " magic-space  # normal space during history searches

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

# other
setopt COMPLETE_IN_WORD
setopt PATH_DIRS
unsetopt CASE_GLOB
setopt AUTO_CD
setopt NULL_GLOB
