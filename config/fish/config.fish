if status is-interactive
  # Homebrew
  if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
  end

  # mise (version manager)
  if test -x /opt/homebrew/bin/mise
    eval (/opt/homebrew/bin/mise activate fish)
  end
end

# fish起動時のメッセージ削除
set fish_greeting
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x EDITOR "nvim"

# abbr
## edit config
abbr -a cnn "cd ~/.config/nvim/ && nvim ./lua/plugins/ # edit neovim config"
abbr -a cnf "cd ~/.config/fish/ && nvim config.fish # edit fish config"

## Vim/Neovim
abbr -a v "nvim"
abbr -a vr "vimr -s"

## git
abbr -a gs "git status"
abbr -a ga "git add"
abbr -a ga. "git add ."
abbr -a gcm "git commit -m"
abbr -a gd "git diff"
abbr -a gdc "git diff --cached"
abbr -a gg "git log --graph --date-order --all --pretty=format:'%h %Cred%d %Cgreen%ad %Cblue%cn %Creset%s' --date=short"

## Neovim
abbr -a blog "cd ~/src/github.com/tkancf/tkancf.com/content && nvim index.md"
abbr -a memo "cd ~/Library/CloudStorage/Dropbox/Memo/ && nvim refile.md"

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

source $HOME/.config/fish/local.fish

zoxide init fish | source

# moonbit
fish_add_path "$HOME/.moon/bin"

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end
