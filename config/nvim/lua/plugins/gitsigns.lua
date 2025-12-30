-- Git 差分表示とサインの設定
return {
  'lewis6991/gitsigns.nvim',
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
      end

      map("<leader>ga", gs.stage_hunk, "Gitsigns Stage Hunk")
      map("<leader>gA", gs.stage_buffer, "Gitsigns Stage Buffer")
      map("<leader>gr", gs.reset_hunk, "Gitsigns Reset Hunk")
      map("<leader>gR", gs.reset_buffer, "Gitsigns Reset Buffer")
      map("<leader>gu", gs.undo_stage_hunk, "Gitsigns Undo Stage Hunk")
      map("<leader>gh", gs.preview_hunk, "Gitsigns Preview Hunk")
      map("<leader>gH", gs.blame_line, "Gitsigns Blame Line")
    end,
  },
}
