return {
  'https://github.com/monaqa/dial.nvim',
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal, -- 整数（10進数）の増減
        augend.integer.alias.hex,     -- 整数（16進数）の増減
        augend.date.alias["%Y/%m/%d"], -- 日付の増減
        augend.constant.alias.bool,  -- true/false のトグル
        -- Default task cycle: TODO → WIP → DONE
        augend.constant.new{
          elements = {"TODO", "WIP", "DONE"},
          word = true,
          cyclic = false,
        },
        augend.constant.new{
          elements = {"WAIT", "TODO"},
          word = true,
          cyclic = false,
        },
        augend.constant.new{
          elements = {"NEXT", "TODO"},
          word = true,
          cyclic = false,
        },
        -- Schedule cycle: SCHE → WIP
        augend.constant.new{
          elements = {"SCHE", "WIP"},
          word = true,
          cyclic = false,
        },
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

