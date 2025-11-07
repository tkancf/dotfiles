#!/bin/bash

set -euo pipefail

usage() {
    cat <<'USAGE'
Usage: $0 [minimal|full]

Deploy dotfiles using symbolic links. Defaults to minimal deployment when no mode is specified.
USAGE
}

MINIMAL_CONFIG=(
    "zshenv:.zshenv"
    "config/sheldon:.config/sheldon"
    "config/nvim:.config/nvim"
)

FULL_CONFIG=(
    "zshenv:.zshenv"
    "config/sheldon:.config/sheldon"
    "vimrc:.vimrc"
    "config/nvim:.config/nvim"
    "config/fish:.config/fish"
    "config/karabiner:.config/karabiner"
    "config/karabiner-config:.config/karabiner-config"
    "config/kitty:.config/kitty"
    "config/lazygit:.config/lazygit"
    "config/mise:.config/mise"
    "config/wezterm:.config/wezterm"
)

MODE="minimal"
if [ $# -gt 1 ]; then
    echo "Error: too many arguments" >&2
    usage
    exit 1
fi

if [ $# -eq 1 ]; then
    case "$1" in
        minimal)
            MODE="minimal"
            ;;
        full)
            MODE="full"
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Error: unknown mode '$1'" >&2
            usage
            exit 1
            ;;
    esac
fi

if [ "$MODE" = "minimal" ]; then
    DOTFILES_CONFIG=("${MINIMAL_CONFIG[@]}")
else
    DOTFILES_CONFIG=("${FULL_CONFIG[@]}")
fi

BACKUP_DIR=".backup/$(date +%Y%m%d%H%M%S)"
mkdir -p "$BACKUP_DIR"

for config in "${DOTFILES_CONFIG[@]}"; do
    IFS=':' read -r source target <<< "$config"
    target_path="$HOME/$target"

    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        mv "$target_path" "$BACKUP_DIR/"
        echo "Backed up: $target_path"
    fi
done

for config in "${DOTFILES_CONFIG[@]}"; do
    IFS=':' read -r source target <<< "$config"
    source_path="$HOME/.config/dotfiles/$source"
    target_path="$HOME/$target"

    mkdir -p "$(dirname "$target_path")"
    ln -sf "$source_path" "$target_path"
    echo "Linked: $source_path -> $target_path"
done
