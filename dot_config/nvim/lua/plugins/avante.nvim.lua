return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    provider = "copilot",
    -- provider = "claude",
    -- provider = "openai",
    auto_suggestions_provider = "copilot",
    behaviour = {
      auto_suggestions = true,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = true,
      support_paste_from_clipboard = true,
    },
    windows = {
      position = "right",
      width = 30,
      sidebar_header = {
        align = "center",
        rounded = false,
      },
      ask = {
        floating = true,
        start_insert = true,
        border = "rounded"
      }
    },
    -- providers-setting
    claude = {
      model = "claude-3-5-sonnet-20240620", -- $3/$15, maxtokens=8000
      -- model = "claude-3-opus-20240229",  -- $15/$75
      -- model = "claude-3-haiku-20240307", -- $0.25/1.25
      max_tokens = 8000,
    },
    copilot = {
      model = "gpt-4o-2024-05-13",
      -- model = "gpt-4o-mini",
      max_tokens = 4096,
    },
    openai = {
      model = "gpt-4o", -- $2.5/$10
      -- model = "gpt-4o-mini", -- $0.15/$0.60
      max_tokens = 4096,
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "stevearc/dressing.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "Avante" },
      },
      ft = { "Avante" },
    },
  },
}
