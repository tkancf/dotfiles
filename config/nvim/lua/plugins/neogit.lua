return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
    },
    config = true,
    keys = {
        { "<leader>gg", function() require("neogit").open() end, desc = "Neogit" },
    },
}
