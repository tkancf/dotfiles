-- Obsidian 連携の設定
return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- use latest release, remove to use latest commit
    ft = "markdown",
    keys = {
        { "<leader>oo", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian Open Note" },
        { "<leader>on", "<cmd>Obsidian new<cr>",          desc = "Obsidian New Note" },
        { "<leader>o/", "<cmd>Obsidian search<cr>",       desc = "Obsidian Search" },
        { "<leader>ot", "<cmd>Obsidian today<cr>",        desc = "Obsidian Today" },
        { "<leader>od", "<cmd>Obsidian dailies<cr>",      desc = "Obsidian Today" },
        { "<leader>ob", "<cmd>Obsidian backlinks<cr>",    desc = "Obsidian Backlinks" },
        { "<leader>or", "<cmd>Obsidian Rename<cr>",       desc = "Obsidian Rename" },
        { "<leader>op", "<cmd>Obsidian pasteimg<cr>",     desc = "Obsidian Paste Image" },
        { "<leader>oT", "<cmd>Obsidian tags<cr>",         desc = "Obsidian Tags" },
    },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
        legacy_commands = false, -- this will be removed in the next major release
        workspaces = {
            {
                name = "Memo",
                path = "~/Memo",
            },
        },
        note_id_func = function(title)
            if title ~= nil and title ~= "" then
                return title
            end
            return tostring(os.time())
        end,
    },
}
