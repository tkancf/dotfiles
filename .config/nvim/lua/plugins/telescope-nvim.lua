return {
  dir = "~/src/github.com/tkancf/telescope-markdown-frontmatter.nvim/",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("telescope").setup({
      extensions = {
        markdown_frontmatter = {
          -- Search directories (default: current directory)
          search_dirs = { "~/src/github.com/tkancf/tkancf.com/content/" },

          -- Directories to exclude from search
          exclude_dirs = { ".git", "node_modules", ".cache", "assets" },

          -- Frontmatter keys to search (can search multiple keys)
          frontmatter_keys = { "title" },

          -- Enable file preview (default: true)
          preview = true,

          -- Custom prompt title
          prompt_title = "Search Markdown Frontmatter",
        }
      }
    })
    -- Load the extension
    require("telescope").load_extension("markdown_frontmatter")
  end,
  keys = {
    {
      "<leader>oo",
      function() require('telescope').extensions.markdown_frontmatter.search() end,
      desc = "Search Markdown Frontmatter"
    }
  }
}
