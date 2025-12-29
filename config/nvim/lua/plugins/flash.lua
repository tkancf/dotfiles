-- 画面内ジャンプを高速化する設定
return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        { "ss", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
}
