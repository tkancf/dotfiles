return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        ---@type wk.Spec
        spec = {
            mode = { "n", "x" },
            { "<leader>f", group = "File/Find" },
            { "<leader>g", group = "Git" },
            { "<leader>l", group = "Lsp" },
        },
        ---@type wk.Spec
        triggers = {
            { "<leader>", mode = { "n", "v" } },
            { "s",        mode = { "n", "v" } },
            { "\"",       mode = { "n", "v" } },
            { "z",        mode = { "n", "v" } },
            { "-",        mode = { "n", "v" } },
            { "g",        mode = { "n", "v" } },
        },
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
