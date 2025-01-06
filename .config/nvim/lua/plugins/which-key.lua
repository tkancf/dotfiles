return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 1000
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>",  group = "Telescope" },
            { "<leader>;", "<cmd>lua require('telescope.builtin').command_history()<cr>", desc = "Command history" },
            { "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>",         desc = "Buffers" },
            { "<leader>f", "<cmd>lua require('telescope.builtin').find_files()<cr>",      desc = "Find Files" },
            { "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>",       desc = "Live Grep" },
            { "<leader>h", "<cmd>lua require('telescope.builtin').help_tags()<cr>",       desc = "Help Tags" },
            { "<leader>u", "<cmd>lua require('telescope.builtin').oldfiles()<cr>",        desc = "Recent Files" },
        })
    end
}
