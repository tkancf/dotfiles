-- ペースト時の履歴とインデント調整を改善する設定
return {
    "hrsh7th/nvim-pasta",
    config = function()
        vim.keymap.set({ "n", "x" }, "p", require("pasta.mapping").p, { desc = "Paste (pasta)" })
        vim.keymap.set({ "n", "x" }, "P", require("pasta.mapping").P, { desc = "Paste before (pasta)" })

        local pasta = require("pasta")
        pasta.config.next_key = vim.keycode("<C-n>")
        pasta.config.prev_key = vim.keycode("<C-p>")
        pasta.config.indent_key = vim.keycode(",")
        pasta.config.indent_fix = false
    end,
}
