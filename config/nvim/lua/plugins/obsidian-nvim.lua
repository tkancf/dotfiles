return {
  'obsidian-nvim/obsidian.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()

    vault_path = os.getenv("OBSIDIAN_VAULT_PATH")

    if vault_path == nil then
      vault_path = "~/src/github.com/tkancf/tkancf.com/content/"
    end

    require("obsidian").setup({
      legacy_commands = false,
      ui = {
        enable = false
      },
      attachments = {
        img_folder = "assets", -- This is the default
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format("![%s](%s)", path.name, path)
        end,
      },
      workspaces = {
        {
          name = "memo",
          path = vault_path,
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      preferred_link_style = "markdown",
      daily_notes = {
        folder = "",
        date_format = "%Y-%m",
        template = nil
      },
      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        note_mappings = {
          -- Create a new note from your query.
          new = "<C-x>",
          -- Insert a link to the selected note.
          insert_link = "<C-l>",
        },
        tag_mappings = {
          -- Add tag(s) to current note.
          tag_note = "<C-x>",
          -- Insert a tag at the current location.
          insert_tag = "<C-l>",
        },
      },
      ---@return string
      note_id_func = function()
        -- Generate a unique ID YYYYMMDDHHMMSS format
        if vault_path == "~/src/github.com/tkancf/tkancf.com/content/" then
          return "blog/" .. tostring(os.date("%Y%m%d%H%M%S"))
        else
          return tostring(os.date("%Y%m%d%H%M%S"))
        end
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
    })

    -- Key map
    vim.api.nvim_create_autocmd("User", {
      pattern = "ObsidianNoteEnter",
      callback = function(ev)
        vim.keymap.set("n", "<leader>ch", "<cmd>Obsidian toggle_checkbox<cr>", {
          buffer = ev.buf,
          desc = "Toggle checkbox",
        })
      end,
    })
  end
}
