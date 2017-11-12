#!/bin/bash
git pull
./configure --with-features=huge --enable-gui=gnome2 \
  --enable-perlinterp --enable-pythoninterp \
  --enable-python3interp --enable-rubyinterp \
  --enable-luainterp --with-luajit \
  --enable-fail-if-missing \
make
