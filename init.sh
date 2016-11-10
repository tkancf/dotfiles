#!/bin/bash

ln -sf ~/src/github.com/tkancf/dotfiles/zsh/zshenv ~/.zshenv

ln -sf ~/src/github.com/tkancf/dotfiles/zsh/zshrc ~/.zshrc

ln -sf ~/src/github.com/tkancf/dotfiles/vimrc ~/.vimrc

if [ -e ~/.config/nvim ]; then
  ln -sf ~/src/github.com/tkancf/dotfiles/nvim ~/.config/nvim
else
  mkdir -p ~/.config
  ln -sf ~/src/github.com/tkancf/dotfiles/nvim ~/.config/nvim
fi
