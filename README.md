# dotfiles

tkancf dotfiles

Main shell: zsh (`zshenv` + `config/zsh`)

## setup

```bash
git clone --depth 1 https://github.com/tkancf/dotfiles ~/.config/dotfiles
brew install mise            # or: curl https://mise.run | sh
# first run only: point mise at the repo config (no ~/.config/mise yet)
MISE_CONFIG_FILE=~/.config/dotfiles/config/mise/config.toml mise bootstrap dotfiles apply
mise bootstrap dotfiles apply   # afterwards, from anywhere
brew bundle --file=Brewfile
```

`mise bootstrap dotfiles apply` is idempotent (converges only what differs) and refuses to overwrite files it doesn't manage without `--force`. On a machine with a pre-existing manual `~/.gitconfig`, use `mise bootstrap dotfiles apply ~/.gitconfig --force` once.

Config sanity checks: `scripts/check.sh` (zsh/fish syntax + brew bundle + mise status).

## minimal

Apply only the core set instead of everything:

```bash
mise bootstrap dotfiles apply ~/.zshenv ~/.config/zsh ~/.config/herdr/config.toml ~/.config/nvim
```

## not deployed

`config/keyboard` (tofu_jr layout) and `config/tmux/session-color.sh` (herdr に未実装の機能) are tracked in the repo for reference but intentionally not deployed.
