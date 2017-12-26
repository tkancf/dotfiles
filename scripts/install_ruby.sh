#!/bin/sh

sudo apt install -y build-essential git libssl-dev

# install rbenv
if [ ! -e '$HOME/.rbenv' ]; then
  git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
fi

# install rbenv
if [ ! -e '$HOME/.rbenv/plugins/ruby-build' ]; then
  git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
fi

rbenv install 2.4.2
rbenv global 2.4.2
