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
  atuin_init="$(atuin init zsh 2>/dev/null)"
  [ -n "$atuin_init" ] && eval "$atuin_init"
  # Restore default up-arrow behaviour; atuin's init binds it to atuin-up-search.
  bindkey -M emacs '^[[A' up-line-or-history
  bindkey -M emacs '^[OA' up-line-or-history
  bindkey -M viins '^[[A' up-line-or-history
  bindkey -M viins '^[OA' up-line-or-history
  bindkey -M vicmd '^[[A' up-line-or-history
  bindkey -M vicmd '^[OA' up-line-or-history
  bindkey -M vicmd 'k' up-line-or-history
fi

# fzf shell integration
if command -v fzf >/dev/null 2>&1; then
  fzf_prefix="${HOMEBREW_PREFIX:-/opt/homebrew}"
  [ -f "$fzf_prefix/opt/fzf/shell/completion.zsh" ] && source "$fzf_prefix/opt/fzf/shell/completion.zsh"
  [ -f "$fzf_prefix/opt/fzf/shell/key-bindings.zsh" ] && source "$fzf_prefix/opt/fzf/shell/key-bindings.zsh"
  [ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
fi

# atuin wins Ctrl-R: fzf's key-bindings.zsh above overrides atuin's ^r binding.
if command -v atuin >/dev/null 2>&1; then
  bindkey -M emacs '^r' atuin-search
  bindkey -M viins '^r' atuin-search-viins
fi

# zsh-autosuggestions (optional)
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Rust/cargo
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

# OPENCODE_API_KEY from 1Password (op://Private/opencode/OPENCODE_API_KEY).
# Keychain に保存しておき起動ごとの 1Password CLI 呼び出しを回避する
# (初回のみ security add-generic-password の許可プロンプトが出る)。
# Keychain が使えない環境向けに ~/.cache/opencode-api-key (0600, 24h TTL) も
# 併用し、両方が無い場合のみ op を叩く。最後に local.zsh がフォールバック。
if command -v op >/dev/null 2>&1 && [[ -z "${OPENCODE_API_KEY:-}" ]]; then
  opencode_key=""
  opencode_key_attr="opencode"
  opencode_key_service="opencode-api-key"
  opencode_key_cache="$HOME/.cache/opencode-api-key"

  # 1) Keychain から読む (login 済みならプロンプトなし)
  if command -v security >/dev/null 2>&1; then
    opencode_key="$(security find-generic-password \
      -s "$opencode_key_service" -a "$opencode_key_attr" -w 2>/dev/null)"
  fi

  # 2) フォールバック: キャッシュファイル (24h 以内)
  if [[ -z "$opencode_key" && -f "$opencode_key_cache" ]]; then
    opencode_cache_age=$(( $(date +%s) - $(stat -f %m "$opencode_key_cache" 2>/dev/null || echo 0) ))
    if (( opencode_cache_age < 86400 )); then
      opencode_key="$(<"$opencode_key_cache")"
    fi
  fi

  # 3) Miss: 1Password から取得して Keychain + キャッシュに保存
  if [[ -z "$opencode_key" ]]; then
    opencode_key="$(op read 'op://Private/opencode/OPENCODE_API_KEY' 2>/dev/null)"
    if [[ -n "$opencode_key" ]]; then
      mkdir -p "${opencode_key_cache:h}"
      opencode_old_umask="$(umask)"
      umask 077
      printf '%s\n' "$opencode_key" > "$opencode_key_cache"
      umask "$opencode_old_umask"
      if command -v security >/dev/null 2>&1; then
        security add-generic-password -s "$opencode_key_service" -a "$opencode_key_attr" \
          -w "$opencode_key" -U >/dev/null 2>&1
      fi
    fi
  fi
  [[ -n "$opencode_key" ]] && export OPENCODE_API_KEY="$opencode_key"
fi

# Local machine settings (gitignored)
local_zsh="${ZDOTDIR:-$HOME/.config/dotfiles/config/zsh}/local.zsh"
[ -f "$local_zsh" ] && source "$local_zsh"
