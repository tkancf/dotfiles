# Remove fish greeging
function fish_greeting
end
# [Alias]
alias ll='ls -alF'
alias l='ls -CF'
alias cb='xsel --clipboard --input'

# git
alias g='git'
alias gg='git graph'
alias ga='git add .'
alias gf='git diff'
alias gfc='git diff --cached'
alias gc='git commit -m'


# [PATH]
# Golang
set -x GOPATH $HOME
set -x PATH $GOPATH $PATH

# Ruby
set -x  PATH $HOME/.rbenv/bin $PATH
source (rbenv init - | psub)
