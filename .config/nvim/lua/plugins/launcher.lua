return {
    {
        'https://github.com/nvim-telescope/telescope.nvim',
        dependencies = { 'https://github.com/nvim-lua/plenary.nvim' },
        event = 'BufWinEnter',
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
            -- vim.api.nvim_set_keymap('n', '<leader>on', '<cmd>obsidiannew<cr>', { noremap = true, silent = true }),
            {
              "<leader>on",
              "<cmd>obsidiannew<cr>",
              desc = "obsidian new"
            },
            -- vim.api.nvim_set_keymap('n', '<leader>os', '<cmd>obsidianfollowlink hsplit<cr>',
            -- { noremap = true, silent = true }),
            {
              "<leader>os",
              "<cmd>obsidianfollowlink hsplit<cr>",
              desc = "obsidian follow link"
            },
            {
              "<leader>ot",
              "<cmd>obsidiantoday<cr>",
              desc = "obsidian today"
            },
            {
              "<leader>ob",
              "<cmd>obsidianbacklinks<cr>",
              desc = "obsidian backlinks"
            },
            {
              --    vim.api.nvim_set_keymap('n', '<leader>oo',
              --        "<cmd>lua require('plugins.tkancf.markdown_title_picker').open_markdown_by_title()<cr>",
              --        { noremap = true, silent = true })
              --end
              "<leader>oo",
              "<cmd>lua require('plugins.tkancf.markdown_title_picker').open_markdown_by_title()<cr>",
              desc = "open markdown by title"
            }
          })
        end,
    },
}
