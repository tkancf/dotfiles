return {
    {
        'thinca/vim-qfreplace'
    },
    {
        'mattn/vim-maketable'
    },
    {
        'rapan931/lasterisk.nvim',
        config = function()
            local lasterisk = require("lasterisk")
            vim.keymap.set('n', '*', function() lasterisk.search() end)
            vim.keymap.set('v', '*', function() lasterisk.search({ is_whole = false }) end)
            vim.keymap.set('n', 'g*', function() lasterisk.search({ is_whole = false }) end)
            vim.keymap.set('x', 'g*', function() lasterisk.search({ is_whole = false }) end)
        end
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            image = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = false },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
    }
}
