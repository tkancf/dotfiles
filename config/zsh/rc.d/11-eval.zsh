if [ -x $HOME/.local/bin/sheldon ]; then
  eval "$($HOME/.local/bin/sheldon source)"
fi

if [ -x /opt/homebrew/bin/mise ]; then
  eval "$(/opt/homebrew/bin/mise activate zsh)"
fi

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -x /opt/homebrew/bin/atuin ]; then
  eval "$(atuin init zsh)"
fi

