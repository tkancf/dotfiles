return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        triggers = {
            { "<leader>", mode = { "n", "v" } },
            { "s",        mode = { "n", "v" } },
            { "\"",       mode = { "n", "v" } },
            { "z",        mode = { "n", "v" } },
            { "-",        mode = { "n", "v" } },
            { "g",        mode = { "n", "v" } },
        }
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
