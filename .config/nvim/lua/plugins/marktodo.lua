return {
  {
    "https://github.com/arakkkkk/marktodo.nvim",
    ft = 'markdown',
    config = function()
      require("marktodo").setup()
    end,
  },
}
