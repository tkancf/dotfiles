if status is-interactive
  # Homebrew
  eval (/opt/homebrew/bin/brew shellenv)

  # zoxide
  $HOME/.local/bin/mise activate fish | source
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
abbr -a cad "chezmoi add ~/.config/nvim/ ~/.config/fish/  ~/.config/wezterm/ ~/.config/lazygit/ ~/.config/wezterm/ ~/.tmux.conf ~/.gitconfig ~/.vimrc ~/.config/mise/"
abbr -a cap "chezmoi init tkancf --apply --ssh -v"
abbr -a capd "chezmoi init tkancf --apply --ssh -v --dry-run"
abbr -a cz "chezmoi"

## Vim/Neovim
abbr -a v "nvim"
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

## Neovim
abbr -a blog "cd ~/src/github.com/tkancf/tkancf.com/content && set -gx NVIM_APPNAME 'nvim' && nvim index.md"
abbr -a memo "set -gx NVIM_APPNAME 'nvim' && cd ~/Library/CloudStorage/Dropbox/Memo/ && nvim refile.md"

## note
abbr -a blog-serve "cd ~/src/github.com/tkancf/tkancf.com/ && npx quartz build --serve"

## fzf
abbr -a bb "abbr --show | fzf"
abbr -a dd "cd (ghq list --full-path | fzf)"

## claude
abbr -a c "claude --dangerously-skip-permissions --continue"

## VSCode
abbr -a e "code ."

# uv
fish_add_path "$HOME/.local/bin"
fish_add_path "/Users/tkan/.local/bin/roc_nightly-macos_apple_silicon-2025-09-09-d73ea109cc2/"
fish_add_path "/Users/tkan/.local/bin/zig-aarch64-macos-0.15.1/"

source $HOME/.config/fish/local.fish

zoxide init fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
