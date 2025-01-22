return {
  'https://github.com/navarasu/onedark.nvim',
  event = 'VimEnter',
  config = function()
    require('onedark').setup {
      style = 'warm'
    }
    require('onedark').load()
  end,
}
