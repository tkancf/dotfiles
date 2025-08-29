local M = {}

function M.setup()
    vim.api.nvim_create_autocmd({ "FileType", "BufReadPost", "BufEnter" }, {
        pattern = "markdown",
        callback = function()
            vim.api.nvim_set_hl(0, 'TodoHighlight', { fg = '#B80000', bg = '#ffffff', bold = true })
            vim.api.nvim_set_hl(0, 'DoneHighlight', { fg = '#00B800', bg = '#ffffff', bold = true })
            vim.api.nvim_set_hl(0, 'ScheduleHighlight', { fg = '#00B800', bold = true })
            vim.api.nvim_set_hl(0, 'DeadlineHighlight', { fg = '#E80000', bold = true })

            vim.fn.matchadd('TodoHighlight', '\\v(#+\\s+)@<=TODO', 100)
            vim.fn.matchadd('DoneHighlight', '\\v(#+\\s+)@<=DONE', 100)
            vim.fn.matchadd('ScheduleHighlight', 'Schedule:', 100)
            vim.fn.matchadd('DeadlineHighlight', 'Deadline:', 100)
        end
    })

    vim.api.nvim_command(
        'command! -nargs=0 TodoSearchInMarkdown lua require"markdown_highlights".SearchTodoInMarkdownFiles()')
end

function M.SearchTodoInMarkdownFiles()
    local path = vim.fn.getcwd()
    local todo_buf = vim.fn.bufnr('__TODO__')

    -- 既に__TODO__バッファがある場合は、そのバッファを削除して再作成
    if todo_buf ~= -1 and vim.api.nvim_buf_is_loaded(todo_buf) then
        -- バッファが開いているウィンドウを取得
        local windows = vim.api.nvim_list_wins()
        for _, window in ipairs(windows) do
            if vim.api.nvim_win_get_buf(window) == todo_buf then
                vim.api.nvim_win_close(window, true)
            end
        end
        vim.api.nvim_buf_delete(todo_buf, { force = true })
    end

    -- 新しいバッファを作成
    todo_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(todo_buf, '__TODO__')

    -- ディレクトリを再帰的にスキャンして.mdファイルを検索
    local function scan_dir(dir)
        local todos = {}
        local handle, err = vim.loop.fs_scandir(dir)
        if handle then
            while true do
                local name, type = vim.loop.fs_scandir_next(handle)
                if not name then break end
                local full_path = dir .. '/' .. name
                if type == 'directory' then
                    vim.list_extend(todos, scan_dir(full_path))
                elseif type == 'file' and name:match('%.md$') then
                    local file = io.open(full_path, "r")
                    if file then
                        local lines = file:lines()
                        local line_number = 1
                        local todo_line = nil
                        local todo_line_number = nil
                        for line in lines do
                            if line:find('^#+ TODO ') then
                                todo_line = line
                                todo_line_number = line_number
                                local formatted_todo_info = string.format('%s:%d', full_path, todo_line_number)
                                -- @s:xxxx-xx-xxの形式の部分を抽出してscheduleに格納する
                                local schedule = todo_line:match("@s:(%d%d%d%d%-%d%d%-%d%d)")
                                -- @d:xxxx-xx-xxの形式の部分を抽出してdeadlineに格納する
                                local deadline = todo_line:match("@d:(%d%d%d%d%-%d%d%-%d%d)")

                                local formatted_todo = string.format('%s',
                                    todo_line:gsub("@s:%d%d%d%d%-%d%d%-%d%d @d:%d%d%d%d%-%d%d%-%d%d", ""))

                                if schedule == nil then
                                    schedule = "None"
                                end
                                if deadline == nil then
                                    deadline = "None"
                                end
                                local formatted_date = string.format('Schedule: %s | Deadline: %s', schedule,
                                    deadline)
                                table.insert(todos, formatted_todo_info)
                                table.insert(todos, formatted_todo)
                                if deadline == "None" and schedule == "None" then
                                else
                                    table.insert(todos, formatted_date)
                                end
                                table.insert(todos, "")
                                todo_line = nil -- Reset the TODO line tracker
                            else
                                todo_line = nil
                            end
                            line_number = line_number + 1
                        end
                        file:close()
                    end
                end
            end
        elseif err then
            vim.api.nvim_err_writeln('Error opening directory ' .. dir .. ': ' .. err)
        end
        return todos
    end

    local todos = scan_dir(path)

    if #todos > 0 then
        vim.api.nvim_buf_set_option(todo_buf, 'modifiable', true)
        vim.api.nvim_buf_set_lines(todo_buf, 0, -1, false, todos)
        vim.api.nvim_buf_set_option(todo_buf, 'modifiable', false)
        vim.api.nvim_command('split')
        vim.api.nvim_win_set_buf(0, todo_buf)
        -- vim.api.nvim_buf_set_option(todo_buf, 'filetype', 'markdown')
    else
        print('No TODOs found.')
    end
end

return M
