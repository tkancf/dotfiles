# [Alias]
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cb='xsel --clipboard --input'

# [PATH]
# Golang
export GOPATH=$HOME
export PATH=$GOPATH:$PATH

# Ruby
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"
