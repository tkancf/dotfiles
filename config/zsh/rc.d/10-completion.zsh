# Completion and ZLE word-style configuration.
# Register user completion functions BEFORE compinit so they are picked up.
fpath+=("$HOME/.zfunc")

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

zstyle ':completion:*:default' menu select=2
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Word characters used by the *-word-match widgets (e.g. Ctrl+W).
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
