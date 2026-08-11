#!/bin/bash
# Config sanity checks: shell syntax + brew bundle consistency.
# Usage: scripts/check.sh   (repo root から、あるいはどこからでも実行可)
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$SCRIPT_DIR"

fail=0

echo "--- zsh syntax check ---"
for f in zshenv config/zsh/.zshrc config/zsh/rc.d/*.zsh; do
  if ! zsh -n "$f"; then fail=1; fi
done

echo "--- fish syntax check ---"
while IFS= read -r -d '' f; do
  if ! fish -n "$f"; then fail=1; fi
done < <(find config/fish -maxdepth 2 -name '*.fish' -print0)

echo "--- brew bundle check ---"
if ! brew bundle check --file=Brewfile; then
  echo "(info) brew bundle に差分あり: 上記のとおり (インストールは brew bundle --file=Brewfile)"
fi

echo "--- mise dotfiles status ---"
if command -v mise >/dev/null 2>&1; then
  mise bootstrap dotfiles status
fi

if [ "$fail" -ne 0 ]; then
  echo "FAILED: シンタックスエラーあり" >&2
  exit 1
fi
echo "OK"
