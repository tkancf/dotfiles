# zsh-syntax-highlighting (optional).
# Must be sourced LAST (per upstream README) so it can wrap all ZLE widgets
# and hooks registered by earlier rc.d files. Sourced after 30-aliases.zsh
# by virtue of the 90- prefix.
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
