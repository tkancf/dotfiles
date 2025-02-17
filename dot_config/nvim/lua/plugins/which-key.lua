return {
  "folke/which-key.nvim",
  dependencies = {
    "https://github.com/echasnovski/mini.icons"
  },
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 1000
  end,
  opts = {}
}
