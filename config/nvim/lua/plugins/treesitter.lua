return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'markdown', 'markdown_inline', 'rust' },
      callback = function()
        vim.treesitter.start()
      end,
    })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'rust' },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}

