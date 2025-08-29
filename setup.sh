#!/bin/bash

DOTFILES_CONFIG=(
    ".zshrc:.zshrc"
    ".zprofile:.zprofile"
    ".vimrc:.vimrc"
    ".config/fish:.config/fish"
    ".config/homebrew:.config/homebrew"
    ".config/karabiner:.config/karabiner"
    ".config/karabiner-config:.config/karabiner-config"
    ".config/kitty:.config/kitty"
    ".config/lazygit:.config/lazygit"
    ".config/mise:.config/mise"
    ".config/wezterm:.config/wezterm"
)

BACKUP_DIR=".backup/$(date +%Y%m%d%H%M%S)"
mkdir -p "$BACKUP_DIR"

for config in "${DOTFILES_CONFIG[@]}"; do
    IFS=':' read -r source target <<< "$config"
    target_path="$HOME/$target"
    
    if [ -e "$target_path" ]; then
        mv "$target_path" "$BACKUP_DIR/"
        echo "Backed up: $target_path"
    fi
done

# シンボリックリンクの作成
for config in "${DOTFILES_CONFIG[@]}"; do
    IFS=':' read -r source target <<< "$config"
    source_path="$HOME/.config/dotfiles/$source"
    target_path="$HOME/$target"
    
    ln -sf "$source_path" "$target_path"
    echo "Linked: $source_path -> $target_path"
done

