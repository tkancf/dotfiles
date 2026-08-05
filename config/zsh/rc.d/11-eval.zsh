# Shell integrations and environment eval.

# Homebrew
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(SHELL=/bin/zsh /opt/homebrew/bin/brew shellenv)"
fi

# mise (version manager)
if [ -x /opt/homebrew/bin/mise ]; then
  eval "$(/opt/homebrew/bin/mise activate zsh)"
fi

# zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# atuin
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh)"
fi

# fzf shell integration
if command -v fzf >/dev/null 2>&1; then
  fzf_prefix="${HOMEBREW_PREFIX:-/opt/homebrew}"
  [ -f "$fzf_prefix/opt/fzf/shell/completion.zsh" ] && source "$fzf_prefix/opt/fzf/shell/completion.zsh"
  [ -f "$fzf_prefix/opt/fzf/shell/key-bindings.zsh" ] && source "$fzf_prefix/opt/fzf/shell/key-bindings.zsh"
  [ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
fi

# zsh-autosuggestions / zsh-syntax-highlighting (optional)
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Rust/cargo
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# OrbStack integration
[ -f "$HOME/.orbstack/shell/init.zsh" ] && source "$HOME/.orbstack/shell/init.zsh"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

# Local machine settings (gitignored)
local_zsh="${ZDOTDIR:-$HOME/.config/dotfiles/config/zsh}/local.zsh"
[ -f "$local_zsh" ] && source "$local_zsh"
