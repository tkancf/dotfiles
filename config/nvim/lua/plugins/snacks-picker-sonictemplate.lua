-- Snacks 用の sonictemplate 連携
return {
    "IMOKURI/snacks-picker-sonictemplate.nvim",
    dependencies = {
        "folke/snacks.nvim",
        "mattn/vim-sonictemplate",
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>t", function() require("snacks_picker").sonictemplate() end, desc = "Sonictemplate" },
    },
    init = function()
        vim.g.sonictemplate_vim_template_dir = { string.format("%s/template", vim.fn.stdpath("config")) }
    end,
}
