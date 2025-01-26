return {
  'https://github.com/nvim-telescope/telescope.nvim',
  event = 'WinEnter',
  config = function()
    local wk = require("which-key")
    wk.add({
      {
        "<leader>;",
        "<cmd>lua telescope command_history()<cr>",
        desc = "command history",
      },
      {
        "<leader>b",
        "<cmd>lua require('telescope.builtin').buffers()<cr>",
        desc = "buffers",
      },
      {
        "<leader>f",
        "<cmd>lua require('telescope.builtin').find_files()<cr>",
        desc = "find files"
      },
      {
        "<leader>g",
        "<cmd>lua require('telescope.builtin').live_grep()<cr>",
        desc = "live grep"
      },
      {
        "<leader>h",
        "<cmd>lua require('telescope.builtin').help_tags()<cr>",
        desc = "help tags"
      },
      {
        "<leader>u",
        "<cmd>lua require('telescope.builtin').oldfiles()<cr>",
        desc = "recent files"
      },
      {
        "<leader>",
        group = "plugins",
      },
      {
        "<leader>p",
        '<cmd>lua require("image_preview").previewimage(vim.fn.getcwd() .. "/" .. vim.fn.expand("<cfile>"))<cr>',
        desc = "preview image"
      },
    })
  end,
}
