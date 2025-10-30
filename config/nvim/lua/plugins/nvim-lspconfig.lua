-- 参考: [今からNeovimを始める人のLSP最短設定 (0.11, 2025-10-04現在)](https://zenn.dev/ras96/articles/4d9d9493d29c06)
return {
  'https://github.com/neovim/nvim-lspconfig',
  event = { "BufReadPre", "BufNewFile" },
}
