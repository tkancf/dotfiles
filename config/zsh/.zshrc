# Load categorized configuration snippets from $ZDOTDIR/rc.d.
rcdir="$ZDOTDIR/rc.d"
if [ -d "$rcdir" ]; then
  for rcfile in $rcdir/*.zsh; do
    [ -r "$rcfile" ] && source "$rcfile"
  done
fi
