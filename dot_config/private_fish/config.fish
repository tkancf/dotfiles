if status is-interactive
  # Homebrew
  eval (/opt/homebrew/bin/brew shellenv)

  # mise
  ## do nothing! mise is automatically activated when using brew and fish
  ## you can disable this behavior with `set -Ux MISE_FISH_AUTO_ACTIVATE 0`


  # zoxide
  zoxide init fish | source

  # スクリプトが既に実行中でない場合のみバックグラウンドで実行
  if not pgrep -f "periodic_script.fish" > /dev/null
    nohup ~/.config/fish/scripts/periodic_script.fish > /dev/null 2>&1 &
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
abbr -a cc "chezmoi cd"
abbr -a cad "chezmoi add ~/.config/nvim/ ~/.config/fish/  ~/.config/wezterm/ ~/.config/lazygit/ ~/.config/wezterm/ ~/.tmux.conf ~/.gitconfig ~/.vimrc ~/.config/mise/"
abbr -a cap "chezmoi init tkancf --apply --ssh -v"
abbr -a capd "chezmoi init tkancf --apply --ssh -v --dry-run"
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

## Neovim
abbr -a blog "cd ~/src/github.com/tkancf/tkancf.com/content && set -gx NVIM_APPNAME 'nvim' && nvim index.md"
abbr -a note "set -gx NVIM_APPNAME 'nvim-note' && cd ~/Library/CloudStorage/Dropbox/Note/ && nvim refile.md"
abbr -a memo "set -gx NVIM_APPNAME 'nvim' && cd ~/Library/CloudStorage/Dropbox/Memo/ && nvim index.md"

## note
abbr -a note-serve "cd ~/src/github.com/tkancf/Note/ && npx quartz build --serve"
abbr -a blog-serve "cd ~/src/github.com/tkancf/tkancf.com/ && npx quartz build --serve"

## fzf
abbr -a bb "abbr --show | fzf"
abbr -a dd "cd (ghq list --full-path | fzf)"

## claude
abbr -a c "claude --dangerously-skip-permissions --continue"

## VSCode
abbr -a e "code ."

# pnpm
set -gx PNPM_HOME "/Users/tkan/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# uv
fish_add_path "/Users/tkan/.local/bin"
