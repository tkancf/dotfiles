return {
  'https://github.com/yuki-yano/lexima-alter-command.vim',
  dependencies = {
    'https://github.com/cohama/lexima.vim'
  },
  event = { 'CmdlineEnter' },
  config = function()
    vim.cmd [[
    LeximaAlterCommand obw ObsidianWorkspace
    LeximaAlterCommand obd ObsidianDailies
    LeximaAlterCommand obt ObsidianToday
    LeximaAlterCommand obe ObsidianExtractNote
    ]]
  end,
}
