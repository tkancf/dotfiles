#################################################
# BASIC OPTION
#################################################

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_all_dups # 過去と重複する行は記録しない
setopt share_history        # 同時に起動したzshの間でヒストリを共有する
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに保存する
setopt HIST_IGNORE_SPACE    # 行頭がスペースのコマンドは記録しない
setopt HIST_IGNORE_ALL_DUPS # 履歴中の重複行をファイル記録前に無くす
setopt HIST_FIND_NO_DUPS    # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_NO_STORE        # histroyコマンドは記録しない
unsetopt beep extendedglob nomatch
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
#eval "$(stack --bash-completion-script stack)"
fpath+=~/.zfunc
zstyle ':completion:*:default' menu select=2
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Disable screen lock short cut to enable Ctrl+s
stty stop undef
stty start undef

# select word div style
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# Enable typo correct
setopt correct

bindkey -e

# colors
autoload colors
colors
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '!'
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:*' formats ' %c%u(%s:%b)'
zstyle ':vcs_info:*' actionformats ' %c%u(%s:%b|%a)'
precmd() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

PROMPT="%B%F{green}❯❯%1(v|%1v|)%f%b %B%F{blue}%~%f%b
%B%F{green}❯%f%b "
PROMPT2="%{$fg[green]%}%_> %{$reset_color%}"
SPROMPT="%{$fg[red]%}correct: %R -> %r [nyae]? %{$reset_color%}"

# locale
export LC_ALL="en_US.UTF-8"

#################################################
# Language Option
#################################################

# go
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# editorconfig
export VISUAL="nvim"
export EDITOR="nvim"

# zoxideがインストールされていたら、zoxideの初期化を行う
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd zsh)"
fi

#################################################
# Function
#################################################

# Peco

function peco-src() {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

#################################################
# Alias
#################################################

# basics
alias ll='ls -alF'
alias l='ls -CF'
alias la='ls -aF'
alias t='tmux -2'
alias vi='vim'
alias brewupdate='cd /tmp/ && \
curl -sO https://gist.githubusercontent.com/tkancf/231b9c11a9a5ea8e93a2fc1a1ea15228/raw/Brewfile &&
brew bundle --file Brewfile --clean &&
rm Brewfile'
# git
alias g='git'
alias gl='git log --graph'
alias gg='git graph'
alias ga='git add .'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit'
alias gm='git commit -m'
# ssh
alias s='ssh'
# nvim
alias n='nvim'

#################################################
# Path
#################################################

typeset -U path PATH
path=(
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /Library/Apple/usr/bin
)
