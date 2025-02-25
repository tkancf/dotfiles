return {
  "https://github.com/epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  opts = {
    ui = {
      enable = true
    },
    attachments = {
      img_folder = "assets", -- This is the default
      ---@param client obsidian.Client
      ---@param path obsidian.Path the absolute path to the image file
      ---@return type string
      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format("![%s](%s)", path.name, path)
      end,
    },
    workspaces = {
      {
        name = "blog",
        path = "~/src/github.com/tkancf/tkancf.com/content/",
      },
      {
        name = "note",
        path = "~/src/github.com/tkancf/note.tkancf.com/content",
      },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    mappings = {
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      ["<cr>"] = {
        action = function()
          if require("obsidian").util.cursor_on_markdown_link(nil, nil, true) then
            return "<cmd>ObsidianFollowLink<CR>"
          end
        end,
        opts = { buffer = true, expr = true },
      }
    },
    preferred_link_style = "markdown",
    daily_notes = {
      folder = "",
      date_format = "%Y-%m",
      template = nil
    },
    templates = {
      subdir = ".config/template",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      substitutions = {
        yesterday = function()
          return os.date("%Y-%m-%d", os.time() - 86400)
        end,
      },
    },
    ---@return string
    note_id_func = function()
      -- Generate a unique ID YYYYMMDDHHMMSS format
      return tostring(os.date("%Y%m%d%H%M%S"))
    end,
    ---@return table
    note_frontmatter_func = function(note)
      if note.title then
        note:add_alias(note.title)
      end
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

      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
        if note.metadata.created then out.created = note.metadata.created end
        if note.metadata.updated then out.updated = note.metadata.updated end
      end

      return out
    end,

    ---@param url string
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url }) -- Mac OS
      -- vim.fn.jobstart({"xdg-open", url})  -- linux
    end,
  },
  keys = {
    {
      "<leader>os",
      "<cmd>ObsidianFollowLink hsplit<cr>",
      desc = "Obsidian Follow Link"
    },
    {
      "<leader>ob",
      "<cmd>ObsidianBacklinks<cr>",
      desc = "Obsidian Backlinks"
    }
  },
}
