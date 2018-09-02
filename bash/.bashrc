#!/usr/bin/env bash

# Source common (bash compatible, and therefore mostly zsh) shell aliases, environment and functions.
. "${HOME}/.commonrc"

# Load readline configuration.
bind -f "${HOME}/.inputrc"

# Bash options.
set -o noclobber  # use >| to force redirection overwrite
shopt -s extglob
shopt -s nullglob
shopt -s nocaseglob
shopt -s globstar
shopt -s autocd
shopt -s cdspell
shopt -s dirspell
shopt -s no_empty_cmd_completion
shopt -s checkwinsize

# History configuration.
export PROMPT_COMMAND="history -a"
export HISTFILESIZE=1000000
export HISTFILE="${HOME}/.bash_history"
export HISTSIZE="$HISTFILESIZE"
export SAVEHIST="$HISTSIZE"
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=ignoreboth
shopt -s cmdhist
shopt -s histappend
bind Space:magic-space
