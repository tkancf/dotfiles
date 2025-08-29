#!/usr/bin/env fish

function run_periodic_script
    while true
        # 実行したいbashスクリプトを指定
        bash ~/src/github.com/tkancf/line-memo-save/scripts/line_memo_organizer.sh
        sleep 20
    end
end

# 実行
run_periodic_script
