# Ruby
export RBENV_PATH=$HOME/.rbenv
if [ -d "$RBENV_PATH" ]; then
  export PATH="$RBENV_PATH/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Golang
export GOPATH="$HOME"
export PATH="$GOPATH/bin:$PATH"

# Rust
export CARGO_PATH=$HOME/.cargo
if [ -d "$CARGO_PATH" ]; then
  source $CARGO_PATH/env
  export PATH="$CARGO_PATH/bin:$PATH"
fi

# Haskell
export PATH="~/.local/bin/stack:$PATH"
export STACK_BIN="$HOME/.stack/bin"
export PATH="$STACK_BIN:$PATH"

# node
export NODE_BIN="$HOME/.node/node-v8.9.3-linux-x64/bin"
export PATH="$NODE_BIN:$PATH"

# MyScripts
export SCRIPTS="$HOME/.dotfiles/scripts"
export PATH="$SCRIPTS:$PATH"

# editorconfig
export VISUAL="/usr/local/bin/vim"
export EDITOR="$VISUAL"
