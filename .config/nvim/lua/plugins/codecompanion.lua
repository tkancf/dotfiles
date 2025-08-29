return {
  "olimorris/codecompanion.nvim",
  event = 'WinEnter',
  opts = {
    language = "日本語",
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
      claude_3_7_sonnet = function()
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
        adapter = "copilot",
      },
      inline = {
        adapter = "copilot",
      },
    },
  },
}
