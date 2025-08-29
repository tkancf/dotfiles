return {
  'https://github.com/monaqa/dial.nvim',
  keys = { "<C-a>", "<C-x>", "g<C-a>", "g<C-x>" },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal, -- 整数（10進数）の増減
        augend.integer.alias.hex,     -- 整数（16進数）の増減
        augend.date.alias["%Y/%m/%d"], -- 日付の増減
        augend.constant.alias.bool,  -- true/false のトグル
      },
    })

    vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
    vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
    vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
    vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
    vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
    vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
  end,
}
