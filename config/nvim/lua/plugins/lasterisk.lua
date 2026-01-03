-- * 検索を拡張する設定
return {
    'rapan931/lasterisk.nvim',
    keys = {
        { "*", function() require("lasterisk").search() end, mode = "n", desc = "Search word under cursor" },
        { "*", function() require("lasterisk").search({ is_whole = false }) end, mode = "x", desc = "Search selection" },
        { "g*", function() require("lasterisk").search({ is_whole = false }) end, mode = "n", desc = "Search word (partial)" },
        { "g*", function() require("lasterisk").search({ is_whole = false }) end, mode = "x", desc = "Search selection (partial)" },
    },
}
