# Aliases and shortcut commands (ported from fish abbreviations).

# basics
alias ll='ls -alF'
alias l='ls -CF'
alias la='ls -aF'
alias e='code .'

# config
cnn() { cd ~/.config/nvim && nvim ./lua/plugins/; }
cnf() { cd ~/.config/dotfiles/config/zsh/rc.d && nvim; }

# vim/neovim
alias v='nvim'
alias vr='vimr -s'
alias vi='vim'
alias n='nvim'

# git
alias gs='git status'
alias ga='git add'
alias ga.='git add .'
alias gcm='git commit -m'
alias gd='git diff'
alias gdc='git diff --cached'
alias gg='git log --graph --date-order --all --pretty=format:"%h %Cred%d %Cgreen%ad %Cblue%cn %Creset%s" --date=short'
alias gl='git log --graph'
alias gc='git commit'
alias gm='git commit -m'

# notes / blog
blog() {
  cd ~/src/github.com/tkancf/tkancf.com/content && nvim index.md
}
memo() {
  cd ~/Library/CloudStorage/Dropbox/Memo/ && nvim refile.md
}
blog-serve() { cd ~/src/github.com/tkancf/tkancf.com/ && npx quartz build --serve; }

# fzf / ghq
bb() { alias | fzf; }
dd() {
  local dir
  dir="$(ghq list --full-path | fzf)"
  [[ -n "$dir" ]] && cd "$dir"
}

# claude
alias c='claude --dangerously-skip-permissions --continue'

# codex helpers (via ocgo)
codex-go() { ocgo launch codex --model deepseek-v4-flash -- "$@"; }
codex-kimi() { ocgo launch codex --model kimi-k3 -- "$@"; }

# ssh
alias s='ssh'
