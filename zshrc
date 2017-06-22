# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt appendhistory autocd notify
unsetopt beep extendedglob nomatch
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tkancf/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Alias
alias ll='ls -alF'
alias l='ls -CF'
alias cb='xsel --clipboard --input'
alias g='git'
alias gg='git graph'
alias ga='git add .'
alias gf='git diff'
alias gfc='git diff --cached'
alias gc='git commit -m'
alias t='tmux -2'

export GOPATH=$HOME
export PATH=$GOPATH:$PATH
