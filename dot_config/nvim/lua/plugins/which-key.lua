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
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
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
      {
        "<leader>os",
        "<cmd>ObsidianFollowLink hsplit<cr>",
        desc = "Obsidian Follow Link"
      },
      {
        "<leader>ob",
        "<cmd>ObsidianBacklinks<cr>",
        desc = "Obsidian Backlinks"
      },
      {
        "<leader>oo",
        "<cmd>lua require('plugins.tkancf.markdown_title_picker').open_markdown_by_title()<cr>",
        desc = "Open Markdown by Title"
      }
    })
  end
}
