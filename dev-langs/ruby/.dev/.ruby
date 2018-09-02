if df_require rbenv; then
    export RBENV_ROOT="${HOME}/.rbenv"
    pathprepend "${PYENV_ROOT}/bin"
    eval "$(rbenv init -)"
else
    df_warn 'rbenv not found'
fi

# these aliases are more like reminders that are nice to have around.
alias buni='bundle install'
alias bune='bundle exec'

export PATH
