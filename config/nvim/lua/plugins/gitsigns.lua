-- Git 差分表示とサインの設定
return {
  'lewis6991/gitsigns.nvim',
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {},
}
