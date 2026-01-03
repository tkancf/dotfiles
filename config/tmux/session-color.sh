#!/usr/bin/env sh
set -eu

session_name="${1:-$(tmux display-message -p "#{session_name}")}"
colors="$(tmux show-option -gv @session_color_list)"
fg="$(tmux show-option -gv @session_color_fg)"

[ -n "$fg" ] || fg="colour231"
set -- $colors
count=$#
[ "$count" -gt 0 ] || exit 0

sessions="$(tmux list-sessions -F "#{session_name}")"
idx=1
i=1
found=0
while IFS= read -r s; do
  if [ "$s" = "$session_name" ]; then
    idx=$i
    found=1
    break
  fi
  i=$((i + 1))
done <<EOF
$sessions
EOF
[ "$found" -eq 1 ] || exit 0
idx=$(((idx - 1) % count + 1))
i=1
for c in "$@"; do
  if [ "$i" -eq "$idx" ]; then
    color="$c"
    break
  fi
  i=$((i+1))
done

tmux set -t "$session_name" status-style "fg=$fg,bg=$color"
tmux set -t "$session_name" window-status-current-style "fg=$fg,bg=$color,bold"
