#!/bin/sh
INSTALL_DIR="${INSTALL_DIR:-$HOME/.config/dotfiles}"

if [ -d "$INSTALL_DIR" ]; then
    echo "Updating dotfiles..."
    git -C "$INSTALL_DIR" pull
else
    echo "Installing dotfiles..."
    git clone "$INSTALL_DIR"
fi

/bin/bash "$INSTALL_DIR/scripts/setup.bash"
