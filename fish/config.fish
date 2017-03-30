# Remove fish greeging
function fish_greeting
end
# [Alias]
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cb='xsel --clipboard --input'

# [PATH]
# Golang
set -x GOPATH $HOME
set -x PATH $GOPATH $PATH

# Ruby
set -x  PATH $HOME/.rbenv/bin $PATH
source (rbenv init - | psub)
