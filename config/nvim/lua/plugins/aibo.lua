-- aibo.nvim を読み込んで初期化する設定
return {
    "lambdalisue/nvim-aibo",
    config = function()
        require("aibo").setup()
    end,
}
