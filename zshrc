# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt appendhistory autocd notify share_history hist_ignore_dups
unsetopt beep extendedglob nomatch
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tkancf/.zshrc'

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
eval "$(stack --bash-completion-script stack)"
fpath+=~/.zfunc
compinit
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

# tmux
if [[ ! -n $TMUX ]]; then
  tmux new-session
fi


# End of lines added by compinstall

# colors
autoload colors
colors
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
PROMPT="%{$fg[green]%}%m%(!.#.$) %{$reset_color%}"
PROMPT2="%{$fg[green]%}%_> %{$reset_color%}"
SPROMPT="%{$fg[red]%}correct: %R -> %r [nyae]? %{$reset_color%}"
RPROMPT="%{$fg[blue]%}[%~]%{$reset_color%}"


if [ -f "$HOME/bin/gomi" ]; then
  alias rm='gomi'
fi

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
  ./configure --with-features=huge --enable-gui=gtk2  --enable-perlinterp --enable-pythoninterp  --enable-python3interp --enable-rubyinterp  --enable-luainterp --with-luajit  --enable-fail-if-missing
  make
  sudo make install
  cd -
}

hugo-server() {
  nohup hugo server -s $HOME/memo &
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
alias ls='ls --color=auto'
alias ll='ls -alF'
alias l='ls -CF'
alias la='ls -aF'
alias cb='xsel --clipboard --input'
alias grep='grep --color=auto'
alias t='tmux -2'
alias vi='vim'
# git
alias gs='git status'
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
