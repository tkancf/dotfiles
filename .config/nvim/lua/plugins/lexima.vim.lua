return {
  'https://github.com/cohama/lexima.vim',
  event = { 'CmdlineEnter', 'InsertEnter' },
  lazy = true,
  config = function()
    vim.g.lexima_enable_space_rules = 0
  end,
}
