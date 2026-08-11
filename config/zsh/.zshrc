# Load categorized configuration snippets from $ZDOTDIR/rc.d.
rcdir="${ZDOTDIR:-$HOME/.config/dotfiles/config/zsh}/rc.d"
if [ -d "$rcdir" ]; then
  for rcfile in "$rcdir"/*.zsh(N); do
    [ -r "$rcfile" ] && source "$rcfile"
  done
fi
