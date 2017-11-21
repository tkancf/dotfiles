# Ruby
export RBENV_PATH=$HOME/.rbenv
if [ -d "$RBENV_PATH" ]; then
  export PATH="$RBENV_PATH/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Golang
export GOPATH="$HOME"
export PATH="$GOPATH:$PATH"

# Rust
export CARGO_PATH=$HOME/.cargo
if [ -d "$CARGO_PATH" ]; then
  source $CARGO_PATH/env
  export PATH="$CARGO_PATH/bin:$PATH"
fi

# Haskell
export STACK_BIN="$HOME/.stack/bin"
export PATH="$STACK_BIN:$PATH"

# firefox-latest
export PATH="/usr/local/firefox:$PATH"
