return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost" },
  lazy = true,
  config = function()
    require 'nvim-treesitter.configs'.setup {
      highlight = {
        ensure_installed = { "markdown" },
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }
  end,
}
