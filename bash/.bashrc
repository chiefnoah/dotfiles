#!/usr/bin/env bash

# bring in common shell aliases, environment and functions
. "${HOME}/.shlib"
. "${HOME}/.commonrc"

export SHELL="$(which bash)"

# prompt
shlib_export_PS1

# load GNU readline configuration
bind -f "${HOME}/.inputrc"

# options
set -o noclobber  # use >| to force redirection overwrite
shopt -s extglob
shopt -s nullglob
shopt -s nocaseglob
shopt -s no_empty_cmd_completion
shopt -s checkwinsize

# options, 4+ only
if [ "${BASH_VERSINFO}" -ge 4 ]; then
    # shopt -s globstar  # recurse all directories with **
    shopt -s autocd
fi

# history
export PROMPT_COMMAND="history -a"
export HISTFILESIZE=1000000
export HISTFILE="${HOME}/.bash_history"
export HISTSIZE="$HISTFILESIZE"
export SAVEHIST="$HISTSIZE"
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=ignoreboth
shopt -s cmdhist
shopt -s histappend
