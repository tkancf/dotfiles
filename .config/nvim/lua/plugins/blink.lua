return {}
--[[
return {
  {
    'saghen/blink.cmp',
    version = '0.*',
    dependencies = {
      -- add source
      { "saghen/blink.compat", lazy = true, version = false }, },
    sources = {
      -- remember to enable your providers here
      default = { 'lsp', 'path', 'snippets', 'buffer', 'digraphs' },
      compat = { "obsidian", "obsidian_new", "obsidian_tags" },
      providers = {
        -- create provider
        digraphs = {
          name = 'digraphs', -- IMPORTANT: use the same name as you would for nvim-cmp
          module = 'blink.compat.source',

          -- all blink.cmp source config options work as normal:
          score_offset = -3,

          -- this table is passed directly to the proxied completion source
          -- as the `option` field in nvim-cmp's source config
          --
          -- this is NOT the same as the opts in a plugin's lazy.nvim spec
          opts = {
            -- this is an option from cmp-digraphs
            cache_digraphs_on_start = true,
          },
        },
      },
    },
  },
}]]
