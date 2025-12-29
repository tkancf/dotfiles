-- 自動ペア挿入を行う nvim-insx 設定
return {
    "hrsh7th/nvim-insx",
    event = "InsertEnter",
    config = function()
        require("insx.preset.standard").setup()
    end,
}
