-- Quickfix/location list UI enhancements
return {
    "stevearc/quicker.nvim",
    ft = "qf",
    keys = {
        {
            "<leader>q",
            function() require("quicker").toggle() end,
            desc = "Toggle quickfix",
        }
    },
    opts = {
        edit = {
            enabled = true,
            autosave = "unmodified",
        },
        constrain_cursor = true,
        highlight = {
            treesitter = true,
            lsp = true,
            load_buffers = false,
        },
        keys = {
            {
                ">",
                function() require("quicker").expand({ before = 2, after = 2 }) end,
                desc = "Expand quickfix context",
            },
            {
                "<",
                function() require("quicker").collapse() end,
                desc = "Collapse quickfix context",
            },
            {
                "R",
                function() require("quicker").refresh() end,
                desc = "Refresh quickfix",
            },
        },
    },
}
