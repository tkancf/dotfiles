return {
  'https://github.com/navarasu/onedark.nvim',
  config = function()
    require('onedark').setup {
      style = 'warm'
    }
    require('onedark').load()
  end,
}
