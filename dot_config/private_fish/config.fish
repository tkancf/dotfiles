if status is-interactive
  # Homebrew
  eval (/opt/homebrew/bin/brew shellenv)

  # mise
  ## do nothing! mise is automatically activated when using brew and fish
  ## you can disable this behavior with `set -Ux MISE_FISH_AUTO_ACTIVATE 0`


  # zoxide
  zoxide init fish | source
end
# fish起動時のメッセージ削除
set fish_greeting
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x EDITOR "nvim"

# abbr
## edit config
abbr -a cnn "cd ~/.config/nvim/ && nvim ./lua/plugins/ # edit neovim config"
abbr -a cnf "cd ~/.config/fish/ && nvim config.fish # edit fish config"
abbr -a cc "chezmoi cd"
abbr -a ca "chezmoi add ~/.config/nvim/ ~/.config/fish/  ~/.config/wezterm/ ~/.config/lazygit/ ~/.config/wezterm/ ~/.tmux.conf ~/.gitconfig ~/.vimrc ~/.config/mise/"
abbr -a cz "chezmoi"

## Vim/Neovim
abbr -a v "neovim"
abbr -a vr "vimr -s"

## git
abbr -a g "lazygit"
abbr -a gs "git status"
abbr -a ga "git add"
abbr -a ga. "git add ."
abbr -a gcm "git commit -m"
abbr -a gd "git diff"
abbr -a gdc "git diff --cached"
abbr -a gg "git log --graph --date-order --all --pretty=format:'%h %Cred%d %Cgreen%ad %Cblue%cn %Creset%s' --date=short"

## fzf
abbr -a bb "abbr --show | fzf"
abbr -a cdg "cd (ghq list --full-path | fzf)"
