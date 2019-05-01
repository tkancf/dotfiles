#!/bin/bash

# vimrc
ln -sf ~/.dotfiles/vimrc ~/.vimrc
ln -sf ~/.dotfiles/vim/ctrlp-launcher ~/.ctrlp-launcher
mkdir ~/.vim/snippets
mkdir ~/.vim/template
mkdir ~/.vim/tmp

ln -sf ~/.dotfiles/snippets/ ~/.vim/snippets
ln -sf ~/.dotfiles/template/ ~/.vim/template
ln -sf ~/.dotfiles/tmp/ ~/.vim/tmp

# bashrc
ln -sf ~/.dotfiles/bashrc ~/.bashrc

# tmux
ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf

# gitconfig
ln -sf ~/.dotfiles/gitconfig ~/.gitconfig

# zsh
ln -sf ~/.dotfiles/zshrc ~/.zshrc
ln -sf ~/.dotfiles/zprofile ~/.zprofile
