return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    --config = true,
    opts = {
      language = "Japanese",
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "codellama:7b",
              },
            },
          })
        end,
      },
      strategies = {
        -- Change the default chat adapter
        chat = {
          adapter = "ollama",
        },
        inline = {
          adapter = "copilot",
        },
      },
    },
  },
  {
    "https://github.com/github/copilot.vim"
  }
}
