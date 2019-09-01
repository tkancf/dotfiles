# Ruby
export RBENV_PATH=$HOME/.rbenv
if [ -d "$RBENV_PATH" ]; then
  export PATH="$RBENV_PATH/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Rust
export CARGO_PATH=$HOME/.cargo
if [ -d "$CARGO_PATH" ]; then
  source $CARGO_PATH/env
  export PATH="$CARGO_PATH/bin:$PATH"
fi

# Haskell
if [ -d "$HOME/.stack" ]; then
  export PATH="~/.local/bin/stack:$PATH"
  export STACK_BIN="$HOME/.stack/bin"
  export HASKELL_BIN="$HOME/.local/bin"
  export PATH="$STACK_BIN:$HASKELL_BIN:$PATH"
fi

# MyScripts
export SCRIPTS="$HOME/.dotfiles/scripts"
export PATH="$SCRIPTS:$PATH"

# anyenv
export ANYENV_PATH="$HOME/.anyenv/bin"
if [ -d "$ANYENV_PATH" ]; then
  export PATH="$ANYENV_PATH:$PATH"
  eval "$(anyenv init -)"
fi

# editorconfig
export VISUAL="/usr/local/bin/vim"
export EDITOR="$VISUAL"

# Golang
export GOPATH="$HOME"
export PATH="$GOPATH/bin:$PATH"
export GO111MODULE=on

# node.js
export PATH="$HOME/.nodebrew/current/bin:$PATH"

#export NPM_BIN="$HOME/.npm-global/bin/"
#export PATH="$NPM_BIN:$PATH"
#export NODENV="$HOME/.nodenv/bin"
#if [ -d "$NODENV" ]; then
#  export PATH="$NODENV:$PATH"
#  eval "$(nodenv init -)"
#fi

export PATH="/usr/local/opt/avr-gcc@7/bin:$PATH"

export PATH="/Users/tkancf/.roswell/bin/:$PATH"

if [ "$PS1"  ] && [ -f '/usr/local/Cellar/coreutils/8.12/aliases'  ]; then
  . /usr/local/Cellar/coreutils/8.12/aliases
fi
export PATH="/usr/local/sbin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"

eval "$(opam env)"
