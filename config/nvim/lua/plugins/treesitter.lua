return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  version = false,
  build = ':TSUpdate',
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'roc', 'markdown', 'markdown_inline', 'rust' },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}

