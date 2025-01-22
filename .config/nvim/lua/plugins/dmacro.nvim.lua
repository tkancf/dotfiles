return {
  'https://github.com/tani/dmacro.nvim',
  event = { 'InsertEnter', 'CursorMoved' },
  config = function()
    vim.keymap.set({ "i", "n" }, '<C-t>', '<Plug>(dmacro-play-macro)')
  end
}
