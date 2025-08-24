return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  config = function ()
    require("snacks").setup({
      indent = {
        enabled = true
      },
      image = {
        enabled = true
      },
    })
    vim.keymap.set('n', '<leader>g', '<cmd>lua Snacks.lazygit()<cr>', { desc = 'Open file explorer' })
  end
}
