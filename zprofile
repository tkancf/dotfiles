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
export PATH="~/.local/bin/stack:$PATH"
export STACK_BIN="$HOME/.stack/bin"
export HASKELL_BIN="$HOME/.local/bin"
export PATH="$STACK_BIN:$HASKELL_BIN:$PATH"

# MyScripts
export SCRIPTS="$HOME/.dotfiles/scripts"
export PATH="$SCRIPTS:$PATH"

# editorconfig
export VISUAL="/usr/local/bin/vim"
export EDITOR="$VISUAL"

# Golang
export GOPATH="$HOME"
export PATH="$GOPATH/bin:$PATH"

# node.js
export NPM_BIN="$HOME/.npm-global/bin/"
export PATH="$NPM_BIN:$PATH"
export NDENV="$HOME/.ndenv/bin"
export PATH="$NDENV:$PATH"
eval "$(ndenv init -)"
