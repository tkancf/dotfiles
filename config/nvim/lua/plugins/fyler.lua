-- ファイルエクスプローラ Fyler の設定
return {
    "A7Lavinraj/fyler.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    branch = "stable",
    event = "VeryLazy",
    keys = {
        { "<leader>ff", "<cmd>Fyler<cr>", desc = "Open Fyler View" },
    },
    opts = {
    },
}
