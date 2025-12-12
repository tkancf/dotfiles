return {
    "A7Lavinraj/fyler.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    branch = "stable",
    lazy = false, -- `default_explorer` が正しく動作するために必要
    keys = {
        { "<leader>e", "<cmd>Fyler<cr>", desc = "Open Fyler View" },
    },
    opts = {
    },
}
