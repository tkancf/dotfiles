return {
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = { 'InsertEnter' },
    opts = function()
      local cmp = require('cmp')
      return {
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
          { name = 'buffer' },
        }),
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
      }
    end,
    config = function(_, opts)
      local cmp = require('cmp')
      cmp.setup(opts)

      -- cmdline設定
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end,
  },
  { 'hrsh7th/vim-vsnip', event = { 'InsertEnter' }, lazy = true, version = false, },
  { 'hrsh7th/cmp-nvim-lsp', event = { 'InsertEnter' }, lazy = true, version = false, },
  { 'hrsh7th/cmp-buffer', event = { 'InsertEnter' }, lazy = true, version = false, },
  { 'hrsh7th/cmp-path', event = { 'InsertEnter' }, lazy = true, version = false, },
  { 'hrsh7th/cmp-cmdline', event = { 'CmdlineEnter' }, lazy = true, version = false, },
}
