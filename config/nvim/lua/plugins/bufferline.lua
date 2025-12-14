return {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            mode = "buffers",
            diagnostics = "nvim_lsp",
            show_buffer_close_icons = false,
            show_close_icon = false,
            separator_style = "thin",
        },
    },
}
