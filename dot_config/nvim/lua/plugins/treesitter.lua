return {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  branch = 'master',
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter.configs').setup({
      -- auto-install parsers
      ensure_installed = { 'lua', 'markdown' },
      highlight = { enable = true },
    })
  end,
}

