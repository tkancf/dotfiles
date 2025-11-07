# Completion and ZLE word-style configuration.
zstyle :compinstall filename '$HOME/.zshrc'

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
#eval "$(stack --bash-completion-script stack)"
fpath+=~/.zfunc
zstyle ':completion:*:default' menu select=2
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
