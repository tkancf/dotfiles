export TERM=xterm-256color
alias ll='ls -alF'
alias l='ls -CF'
alias cb='xsel --clipboard --input'
alias g='git'
alias gg='git graph'
alias ga='git add .'
alias gf='git diff'
alias gfc='git diff --cached'
alias gc='git commit -m'
alias t='tmux'
alias s='ssh'
tmux

# added by Anaconda2 4.3.1 installer
#export PATH="/home/tkancf/anaconda2/bin:$PATH"
#
#export GOPATH=$HOME
#export PATH=$GOPATH:$PATH

# Golang
export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH

export LINUXBREW="$HOME/.linuxbrew/bin"
if [ condition ]; then
  export PATH="$LI:$PATH"
  export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
  export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

fi
export PATH="$PATH":"$HOME/.pub-cache/bin"
