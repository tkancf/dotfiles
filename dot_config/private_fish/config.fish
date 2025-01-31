if status is-interactive
    # Commands to run in interactive sessions can go here
end
# fish起動時のメッセージ削除
set fish_greeting

abbr -a cnv "cd ~/.config/nvim/ && nvim ./lua/plugins/"
