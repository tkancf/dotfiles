# locale
export LC_ALL="en_US.UTF-8"

# Ruby
export RBENV_PATH=$HOME/.rbenv
if [ -d "$RBENV_PATH" ]; then
  export PATH="$RBENV_PATH/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Rust
export CARGO_PATH=$HOME/.cargo
if [ -d "$CARGO_PATH" ]; then
  source $CARGO_PATH/env
  export PATH="$CARGO_PATH/bin:$PATH"
fi

# Haskell
if [ -d "$HOME/.stack" ]; then
  export PATH="~/.local/bin/stack:$PATH"
  export STACK_BIN="$HOME/.stack/bin"
  export HASKELL_BIN="$HOME/.local/bin"
  export PATH="$STACK_BIN:$HASKELL_BIN:$PATH"
fi

# MyScripts
export SCRIPTS="$HOME/.dotfiles/scripts"
export PATH="$SCRIPTS:$PATH"

# anyenv
export ANYENV_PATH="$HOME/.anyenv/bin"
if [ -d "$ANYENV_PATH" ]; then
  export PATH="$ANYENV_PATH:$PATH"
  eval "$(anyenv init -)"
fi

# editorconfig
export VISUAL="/usr/local/bin/vim"
export EDITOR="$VISUAL"

# Golang
export GOROOT=$( go env GOROOT )
export GOPATH="$HOME"
export PATH="$GOPATH/bin:$PATH"
export GO111MODULE=on

# node.js
export PATH="$HOME/.nodebrew/current/bin:$PATH"

# gcc
# export PATH="/usr/local/opt/avr-gcc@7/bin:$PATH"

# roswell
# export PATH="/Users/tkancf/.roswell/bin/:$PATH"

# coreutils
if [ "$PS1"  ] && [ -f '/usr/local/Cellar/coreutils/8.12/aliases'  ]; then
  . /usr/local/Cellar/coreutils/8.12/aliases
fi
export PATH="/usr/local/sbin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt appendhistory autocd notify share_history hist_ignore_dups
unsetopt beep extendedglob nomatch
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tkancf/.zshrc'

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

# End of lines added by compinstall

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
precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_"  ]] && psvar[1]="$vcs_info_msg_0_"
}

PROMPT="%B%F{green}❯❯%1(v|%1v|)%f%b %B%F{blue}%~%f%b
%B%F{green}❯%f%b "
#PROMPT="%{$fg[green]%}%m%(!.#.$) %{$reset_color%}"
PROMPT2="%{$fg[green]%}%_> %{$reset_color%}"
SPROMPT="%{$fg[red]%}correct: %R -> %r [nyae]? %{$reset_color%}"
#RPROMPT="%{$fg[blue]%}[%~]%{$reset_color%}"


if [ -f "$HOME/bin/gomi" ]; then
  alias rm='gomi'
fi

local git==git
branchname=`${git} symbolic-ref --short HEAD 2> /dev/null`
function git(){hub "$@"} # zsh

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

## vim build
function Vim-build () {
  local vim_source_dir="$HOME/src/github.com/vim/vim"
  cd $vim_source_dir
  git pull
  ./configure --with-features=huge --enable-gui=gtk2  --enable-perlinterp --enable-rubyinterp  --enable-luainterp --with-lua-prefix=/usr/local/Cellar/lua/5.3.5_1 --enable-fail-if-missing
  make
  sudo make install
  cd -
}

function anyenv-install ()
{
  git clone https://github.com/riywo/anyenv ~/.anyenv
  exec $SHELL -l
}

ssh() {
  if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
    tmux rename-window ${@: -1} # <---- ここ
    command ssh "$@"
    tmux set-window-option automatic-rename "on" 1>/dev/null
  else
    command ssh "$@"
  fi
}

# Alias
# for mac
alias awk='gawk'

# basics
alias ll='ls -alF'
alias l='ls -CF'
alias la='ls -aF'
alias cb='xsel --clipboard --input'
alias grep='ggrep --color=auto'
alias t='tmux -2'
alias vi='vim'
# git
alias g='git'
alias gl='git log --graph'
alias gg='git graph'
alias ga='git add .'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit'
alias gcm='git commit -m'
# stack
alias runghc='stack runghc --'
alias ghci='stack ghci --'
alias ghc='stack ghc --'
alias s='ssh'
# scheme
alias gos='rlwrap gosh'
alias sicp='racket -i -p neil/sicp -l xrepl'
