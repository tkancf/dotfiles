#!/usr/bin/env bash
set -x
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

mkdir -p \
    "$XDG_CONFIG_HOME" \
    "$XDG_STATE_HOME" \
    "$XDG_DATA_HOME"

ln -sfv "$REPO_CONF_DIR/config/"* "$XDG_CONFIG_HOME"
ln -sfv "$REPO_CONF_DIR/vim" "$HOME/.vim"
ln -sfv "$REPO_CONF_DIR/vim/.vimrc" "$HOME/.vimrc"
ln -sfv "$REPO_CONF_DIR/zsh/.zshenv" "$HOME/.zshenv"
