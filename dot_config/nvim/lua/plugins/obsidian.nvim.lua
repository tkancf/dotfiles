return {
  {
    "https://github.com/epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      -- Required.
      -- 'https://github.com/nvim-lua/plenary.nvim',
      -- 'https://github.com/hrsh7th/nvim-cmp',
      -- 'https://github.com/nvim-telescope/telescope.nvim',
      -- 'https://github.com/nvim-treesitter/nvim-treesitter',
      -- see below for full list of optional dependencies 👇
    },
    opts = {
      ui = {
        enable = true
      },
      attachments = {
        img_folder = "assets", -- This is the default
        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
        -- This is the default implementation.
        ---@param client obsidian.Client
        ---@param path obsidian.Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format("![%s](%s)", path.name, path)
        end,
      },
      -- Base dir of Obsidian vault
      workspaces = {
        {
          name = "Memo",
          path = "~/Dropbox/Memo",
        },
        {
          name = "Note",
          path = "~/Dropbox/Note",
        },
        {
          name = "note.tkancf.com",
          path = "~/src/github.com/tkancf/note.tkancf.com/content",
        },
      },
      completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },
      -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
      -- way then set 'mappings = {}'.
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            if require("obsidian").util.cursor_on_markdown_link(nil, nil, true) then
              return "<cmd>ObsidianFollowLink<CR>"
            end
          end,
          opts = { buffer = true, expr = true },
        }
      },
      -- Either 'wiki' or 'markdown'.
      preferred_link_style = "markdown",

      -- Daily note settings.
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil
      },

      -- Template settings.
      templates = {
        subdir = ".config/template",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {
          yesterday = function()
            return os.date("%Y-%m-%d", os.time() - 86400)
          end,
        },
      },
      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Generate a unique ID YYYYMMDDHHMMSS format
        return tostring(os.date("%Y%m%d%H%M%S"))
      end,

      -- Optional, alternatively you can customize the frontmatter data.
      ---@return table
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end

        -- Create timestamps for created and updated times
        local created_time = os.date("%Y-%m-%d %H:%M") -- ISO 8601 format
        local updated_time = created_time              -- Initially, created and updated times are the same

        -- Initialize the frontmatter table
        local out = {
          id = note.id,
          title = note.title,
          aliases = note.aliases,
          tags = note.tags,
          created = created_time,
          updated = updated_time
        }

        -- If note.metadata already has created or updated, use those values instead
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
          if note.metadata.created then out.created = note.metadata.created end
          if note.metadata.updated then out.updated = note.metadata.updated end
        end

        return out
      end,

      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      ---@param url string
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart({ "open", url }) -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
      end,
    },
  },
}
