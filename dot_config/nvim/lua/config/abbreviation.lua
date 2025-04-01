-- 方法2: 関数を作成して設定
local function set_abbrev(mode, from, to)
    vim.cmd(string.format('%sabbrev %s %s', mode, from, to))
end

-- set_abbrev('i', 'adn', 'and')
-- set_abbrev('c', 'h', 'help')   -- command mode
set_abbrev('c', 'obw', 'ObsidianWorkspace')
set_abbrev('c', 'obe', 'ObsidianExtractNote')
