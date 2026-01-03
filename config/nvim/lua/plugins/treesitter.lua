-- Tree-sitter による構文解析の設定
return {
  'nvim-treesitter/nvim-treesitter',
  event = { "BufReadPre", "BufNewFile" },
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
