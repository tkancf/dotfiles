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

`mise bootstrap dotfiles apply` is idempotent (converges only what differs) and refuses to overwrite files it doesn't manage without `--force`.

## minimal

Apply only the core set instead of everything:

```bash
mise bootstrap dotfiles apply ~/.zshenv ~/.config/zsh ~/.config/herdr/config.toml ~/.config/nvim
```
