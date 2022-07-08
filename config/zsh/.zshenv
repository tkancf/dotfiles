# locale
export LANG="en_US.UTF-8"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Go
export GOPATH="$XDG_DATA_HOME/go"
export GO111MODULE="on"

# Deno
export DENO_INSTALL="$XDG_DATA_HOME/deno"
