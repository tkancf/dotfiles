-- 必要なモジュールをインポート
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local previewers = require('telescope.previewers')
local Job = require('plenary.job')

-- モジュールテーブルを作成
local M = {}

-- ag コマンドを使ってディレクトリ内の Markdown ファイルからタイトルを非同期に抽出する
local function extract_titles_with_ag(dir, callback)
  local titles = {}
  Job:new({
    command = 'ag',
    args = { '-l', '--md', '--nobreak', 'title: ', dir },
    on_exit = vim.schedule_wrap(function(job, return_val)
      if return_val == 0 then
        local result = job:result()
        for _, line in ipairs(result) do
          local filepath = line
          local file = io.open(filepath, "r")
          if file then
            local content = file:read("*all")
            file:close()

            -- タイトルを抽出 (Luaのネイティブなパターンマッチを使用)
            local title = content:match("title: ([^\n]+)")
            if title then
              table.insert(titles, { title = title, filepath = filepath })
            end
          end
        end
        callback(titles)
      else
        print("ag コマンドの実行に失敗しました")
        callback({})
      end
    end),
  }):start()
end

-- Markdown ファイルをタイトルで開くためのメイン関数
function M.open_markdown_by_title()
  local current_dir = vim.fn.getcwd() -- 現在の作業ディレクトリを取得

  -- 非同期でタイトルを抽出
  extract_titles_with_ag(current_dir, function(titles)
    -- Telescope ピッカーを起動
    pickers.new({}, {
      prompt_title = 'Open Markdown by Title',
      finder = finders.new_table({
        results = titles,
        entry_maker = function(entry)
          return {
            value = entry.filepath,
            display = entry.title,
            ordinal = entry.title,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = previewers.vim_buffer_cat.new({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          vim.cmd('edit ' .. selection.value)
        end)
        return true
      end,
    }):find()
  end)
end

-- モジュールテーブルを返す
return M
