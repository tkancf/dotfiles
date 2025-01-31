if status is-interactive
  # Homebrew
  eval (/opt/homebrew/bin/brew shellenv)

  # mise
  ## do nothing! mise is automatically activated when using brew and fish
  ## you can disable this behavior with `set -Ux MISE_FISH_AUTO_ACTIVATE 0`
end
# fish起動時のメッセージ削除
set fish_greeting

# abbr
abbr -a cnn "cd ~/.config/nvim/ && nvim ./lua/plugins/ # edit neovim config"
abbr -a cnf "cd ~/.config/fish/ && nvim config.fish # edit fish config"
