---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                -- Neovim の runtime と lazy.nvim の plugin を全て読む
                library = {
                    vim.env.VIMRUNTIME,
                    vim.fn.expand("~/.local/share/nvim/lazy"),
                    vim.fn.stdpath("config") .. "/lua",
                },
            },
        },
    },
}
