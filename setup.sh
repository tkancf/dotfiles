#!/bin/bash

set -euo pipefail

usage() {
    cat <<'USAGE'
Usage: $0 [minimal|full]

Deploy dotfiles using symbolic links. Defaults to minimal deployment when no mode is specified.
USAGE
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MINIMAL_CONFIG=(
    "zshenv:.zshenv"
    "config/zsh:.config/zsh"
    "config/herdr/config.toml:.config/herdr/config.toml"
    "config/nvim:.config/nvim"
)

FULL_CONFIG=(
    "vimrc:.vimrc"
    "config/nvim:.config/nvim"
    "zshenv:.zshenv"
    "config/zsh:.config/zsh"
    "config/fish:.config/fish"
    "config/mise:.config/mise"
    "config/ghostty:.config/ghostty"
    "config/herdr/config.toml:.config/herdr/config.toml"
    "config/opencode:.config/opencode"
    "config/agents/skills/herdr:.agents/skills/herdr"
    "tmux.conf:.tmux.conf"
    "gitignore:.gitignore"
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

# Verify all sources exist before touching anything, so a fresh clone or a
# moved repo fails loudly instead of producing broken symlinks.
for config in "${DOTFILES_CONFIG[@]}"; do
    IFS=':' read -r source _ <<< "$config"
    source_path="$SCRIPT_DIR/$source"
    if [ ! -e "$source_path" ]; then
        echo "Error: source not found: $source_path" >&2
        exit 1
    fi
done

BACKUP_DIR="$SCRIPT_DIR/.backup/$(date +%Y%m%d%H%M%S)"
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
    source_path="$SCRIPT_DIR/$source"
    target_path="$HOME/$target"

    mkdir -p "$(dirname "$target_path")"
    ln -sf "$source_path" "$target_path"
    echo "Linked: $source_path -> $target_path"
done

# Keep only the 5 most recent backups. `|| true` guards against the case
# where no .backup/ directory exists yet (ls fails under pipefail).
ls -1dt "$SCRIPT_DIR"/.backup/*/ 2>/dev/null | tail -n +6 | while IFS= read -r dir; do
    rm -rf "$dir"
    echo "Pruned old backup: $dir"
done || true
