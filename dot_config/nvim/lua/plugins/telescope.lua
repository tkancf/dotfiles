return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()

      -- Using Lua functions
      local builtin = require('telescope.builtin')
      local actions = require('telescope.actions')
      vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Telescope live grep' })
      --vim.keymap.set('n', '<leader>b', builtin.buffers, { noremap = true, silent = true, desc = "Telescope buffers" })

      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ["<c-d>"] = actions.delete_buffer,
            },
            n = {
              ["<c-d>"] = actions.delete_buffer,
              ["dd"] = actions.delete_buffer,
            },
          },
        },
      }
    end,
  },
  {
    'tkancf/telescope-markdown-frontmatter.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      -- Search specific fields
      vim.keymap.set("n", "<leader>o", function()
        require("telescope").extensions.markdown_frontmatter.title()
      end, { desc = "Telescope Obsidian Title" })
    end
  },
}
