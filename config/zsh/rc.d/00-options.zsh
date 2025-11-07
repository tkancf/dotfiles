# General shell options and history behaviour.



# Lines configured by zsh-newuser-install
setopt hist_ignore_all_dups # 過去と重複する行は記録しない
setopt share_history        # 同時に起動したzshの間でヒストリを共有する
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに保存する
setopt HIST_IGNORE_SPACE    # 行頭がスペースのコマンドは記録しない
setopt HIST_IGNORE_ALL_DUPS # 履歴中の重複行をファイル記録前に無くす
setopt HIST_FIND_NO_DUPS    # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_NO_STORE        # historyコマンドは記録しない
unsetopt beep extendedglob nomatch
# End of lines configured by zsh-newuser-install

# Disable XON/XOFF so Ctrl+S works, then enable typo correction and keymap.
stty stop undef
stty start undef
setopt correct
bindkey -e
