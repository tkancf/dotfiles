# Environment configuration that should apply to every Zsh invocation.
export ZDOTDIR="$HOME/.config/dotfiles/config/zsh"

# History file configuration
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Locale and editor defaults
export LC_ALL="en_US.UTF-8"
export VISUAL="nvim"
export EDITOR="nvim"

typeset -U path PATH
path=(
  $HOME/Library/pnpm/bin(N-/)
  $HOME/.moon/bin(N-/)
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /Library/Apple/usr/bin
  $HOME/.local/bin
  $HOME/.local/bin/roc_nightly-macos_apple_silicon-2025-09-09-d73ea109cc2/(N-/)
  $HOME/.local/bin/zig-aarch64-macos-0.15.1/(N-/)
)
