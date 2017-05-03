# Remove fish greeging
function fish_greeting
end
# [Alias]
alias ll='ls -alF'
alias l='ls -CF'
alias cb='xsel --clipboard --input'

alias g='git'

# [PATH]
# Golang
set -x GOPATH $HOME
set -x PATH $GOPATH $PATH

# Ruby
set -x  PATH $HOME/.rbenv/bin $PATH
source (rbenv init - | psub)
