return {
    "https://github.com/WilliamHsieh/overlook.nvim",
    keys = {
        { "<leader>pd", function() require("overlook.api").peek_definition() end,         desc = "Peek definition" },
        { "<leader>pp", function() require("overlook.api").peek_cursor() end,             desc = "Peek cursor" },
        { "<leader>pu", function() require("overlook.api").restore_popup() end,           desc = "Restore last popup" },
        { "<leader>pU", function() require("overlook.api").restore_all_popups() end,      desc = "Restore all popups" },
        { "<leader>pc", function() require("overlook.api").close_all() end,               desc = "Close all popups" },
        { "<leader>pf", function() require("overlook.api").switch_focus() end,            desc = "Switch focus" },
        { "<leader>ps", function() require("overlook.api").open_in_split() end,           desc = "Open popup in split" },
        { "<leader>pv", function() require("overlook.api").open_in_vsplit() end,          desc = "Open popup in vsplit" },
        { "<leader>pt", function() require("overlook.api").open_in_tab() end,             desc = "Open popup in tab" },
        { "<leader>po", function() require("overlook.api").open_in_original_window() end, desc = "Open popup in current window" },
    },
    opts = {},
}
