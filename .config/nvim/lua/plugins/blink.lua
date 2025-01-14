return {
  {
    'saghen/blink.cmp',
    enabled = false,
    version = '*',
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
      { "saghen/blink.compat", lazy = true, version = false },
      { "https://github.com/epwalsh/obsidian.nvim" },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'enter' },
      completion = { list = { selection = { preselect = false, auto_insert = false } } },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "obsidian", "obsidian_new", "obsidian_tags", "lsp", "path", "snippets", "buffer", "codecompanion" },
        providers = {
          obsidian = {
            name = "obsidian",
            module = "blink.compat.source",
          },
          obsidian_new = {
            name = "obsidian_new",
            module = "blink.compat.source",
          },
          obsidian_tags = {
            name = "obsidian_tags",
            module = "blink.compat.source",
          },
        },
      },
    },
    opts_extend = { "sources.default" }
  }
}

