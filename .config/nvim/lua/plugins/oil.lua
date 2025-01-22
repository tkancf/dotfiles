return {
  {
    'https://github.com/stevearc/oil.nvim',
    event = "BufRead",
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
  },
}
