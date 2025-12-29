-- nvim-snippy のスニペット設定
return {
    "dcampos/nvim-snippy",
    dependencies = {
        "dcampos/cmp-snippy",
    },
    opts = {
        mappings = {
            is = {
                ["<C-k>"] = "expand_or_advance",
                ["<C-j>"] = "previous",
            },
            x = {
                ["<C-k>"] = "cut_text",
            },
        },
    },
}
