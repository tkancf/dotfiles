# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt appendhistory autocd notify
unsetopt beep extendedglob nomatch
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tkancf/.zshrc'

autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=2

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# End of lines added by compinstall
# colors
autoload colors
colors
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
PROMPT="%{$fg[green]%}%m%(!.#.$) %{$reset_color%}"
PROMPT2="%{$fg[green]%}%_> %{$reset_color%}"
SPROMPT="%{$fg[red]%}correct: %R -> %r [nyae]? %{$reset_color%}"
RPROMPT="%{$fg[blue]%}[%~]%{$reset_color%}"
# Alias
alias ls='ls --color=auto'
alias ll='ls -alF'
alias l='ls -CF'
alias cb='xsel --clipboard --input'
alias grep='grep --color=auto'
alias g='git'
alias gg='git graph'
alias ga='git add .'
alias gf='git diff'
alias gfc='git diff --cached'
alias gc='git commit -m'
alias t='tmux -2'
alias vi='vim'

# Function
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src
