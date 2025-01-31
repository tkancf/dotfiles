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
## edit config
abbr -a cnn "cd ~/.config/nvim/ && nvim ./lua/plugins/ # edit neovim config"
abbr -a cnf "cd ~/.config/fish/ && nvim config.fish # edit fish config"
abbr -a czc "chezmoi cd"
abbr -a cza "chezmoi re-add ~/.config/"
abbr -a cz "chezmoi"

## git
abbr -a gs "git status"
abbr -a ga "git add"
abbr -a ga. "git add ."
abbr -a gcm "git commit -m"
abbr -a gd "git diff"
abbr -a gdc "git diff --cached"

## fzf
abbr -a bb "abbr --show | fzf"
