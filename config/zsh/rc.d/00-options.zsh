# General shell options and history behaviour.
setopt hist_ignore_all_dups # 過去と重複する行は記録しない(ファイル保存時にも適用)
setopt share_history        # 同時に起動したzshの間でヒストリを共有する
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに保存する
setopt HIST_IGNORE_SPACE    # 行頭がスペースのコマンドは記録しない
setopt HIST_FIND_NO_DUPS    # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_NO_STORE        # historyコマンドは記録しない
unsetopt beep nomatch

# Disable XON/XOFF so Ctrl+S works, then enable typo correction and keymap.
# Guard terminal-only commands with a tty check: they error when stdin is
# not a terminal (e.g. `zsh -i` under a pipe/CI).
if [[ -t 0 ]]; then
  stty stop undef
  stty start undef
  bindkey -e
fi
setopt correct
