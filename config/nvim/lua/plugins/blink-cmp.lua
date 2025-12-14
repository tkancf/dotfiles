return {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    opts = {
        sources = {
            default = { "lsp", "path", "buffer" },
        },
        keymap = {
            preset = "default", -- nvim-cmpに近いキーマップ
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            ["<C-Space>"] = { "show" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<CR>"] = { "accept", "fallback" }, -- nvim-cmpのconfirmに相当
        },
        completion = {
            accept = { select = true }, -- Enterで選択確定を許可
            list = { selection = { preselect = true, auto_insert = true } },
        },
        signature = { enabled = true },
    },
    config = function(_, opts)
        require("blink.cmp").setup(opts)
    end,
}
