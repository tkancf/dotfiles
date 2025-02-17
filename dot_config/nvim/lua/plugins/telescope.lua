return {
  'https://github.com/nvim-telescope/telescope.nvim',
  event = 'WinEnter',
  keys = {
    {
      "<leader>t;",
      "<cmd>lua telescope command_history()<cr>",
      desc = "command history",
    },
    {
      "<leader>tb",
      "<cmd>lua require('telescope.builtin').buffers()<cr>",
      desc = "buffers",
    },
    {
      "<leader>tf",
      "<cmd>lua require('telescope.builtin').find_files()<cr>",
      desc = "find files"
    },
    {
      "<leader>tg",
      "<cmd>lua require('telescope.builtin').live_grep()<cr>",
      desc = "live grep"
    },
    {
      "<leader>th",
      "<cmd>lua require('telescope.builtin').help_tags()<cr>",
      desc = "help tags"
    },
    {
      "<leader>tu",
      "<cmd>lua require('telescope.builtin').oldfiles()<cr>",
      desc = "recent files"
    },
  }
}
