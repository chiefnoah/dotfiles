#!/usr/bin/env zsh

export SHELL="$(which zsh)"

# bring in common shell aliases, environment and functions
. "${HOME}/.shlib"
. "${HOME}/.commonrc"

# completion adjustments
autoload -Uz compinit && compinit
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' special-dirs false
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:users' ignored-patterns '_*'

# prompt
# need to redefine colors so zsh knows the control characters don't need to show up in terminal
shlib_c_fg_green='%{\e[32m%}'
shlib_c_fg_cyan='%{\e[36m%}'
shlib_c_fg_red_bold='%{\e[1;31m%}'
shlib_c_fg_white_bold='%{\e[1;97m%}'
shlib_c_reset='%{\e[0m%}'
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
