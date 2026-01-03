-- ペースト時の履歴とインデント調整を改善する設定
return {
    "hrsh7th/nvim-pasta",
    keys = {
        { "p", function() require("pasta.mapping").p() end, mode = { "n", "x" }, desc = "Paste (pasta)" },
        { "P", function() require("pasta.mapping").P() end, mode = { "n", "x" }, desc = "Paste before (pasta)" },
    },
    config = function()
        local pasta = require("pasta")
        pasta.config.next_key = vim.keycode("<C-n>")
        pasta.config.prev_key = vim.keycode("<C-p>")
        pasta.config.indent_key = vim.keycode(",")
        pasta.config.indent_fix = false
    end,
}
