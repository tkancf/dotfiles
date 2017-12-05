#!/bin/sh
sudo apt install git gettext libtinfo-dev libacl1-dev libgpm-dev build-essential libxmu-dev libgtk2.0-dev libxpm-dev libperl-dev python-dev python3-dev ruby-dev liblua5.3-0 liblua5.3-dev luajit libluajit-5.1-dev
export VIM_REPO="$HOME/src/github.com/vim/vim"

if [ -e $VIM_REPO ]; then
# Update Vim
  cd $VIM_REPO
  git pull
  ./configure --with-features=huge --enable-gui=gtk2  --enable-perlinterp --enable-pythoninterp  --enable-python3interp --enable-rubyinterp  --enable-luainterp --with-luajit  --enable-fail-if-missing
  make
  sudo make install
  cd -
else
  mkdir -p $VIM_REPO
  git clone https://github.com/vim/vim.git $VIM_REPO
  cd $VIM_REPO
  ./configure --with-features=huge --enable-gui=gtk2  --enable-perlinterp --enable-pythoninterp  --enable-python3interp --enable-rubyinterp  --enable-luainterp --with-luajit  --enable-fail-if-missing
  make
  sudo make install
  cd -
fi

