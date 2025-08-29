local picker = require("snacks.picker")

local function get_markdown_files()
  local handle = io.popen('find . -type f -name "*.md"')
  if not handle then return {} end
  local files = handle:read("*a")
  handle:close()
  return files
end

local function extract_titles_from_file(file)
  local items = {}
  local idx = 1
  local f = io.open(file, "r")
  if f then
    local content = f:read("*all")
    f:close()
    for line in content:gmatch("[^\n]+") do
      local title = line:match("^title:%s*(.+)")
      if title then
        table.insert(items, {
          idx = idx,
          score = 0,
          text = title,
          file = file,
          line = line,
        })
        idx = idx + 1
      end
    end
  end
  return items
end

local function markdown_titles()
  local items = {}
  local files = get_markdown_files()
  for file in files:gmatch("[^\n]+") do
    local file_items = extract_titles_from_file(file)
    for _, item in ipairs(file_items) do
      table.insert(items, item)
    end
  end

  picker({
    finder = function() return items end,
    confirm = function(the_picker, item)
      the_picker:close()
      vim.cmd('edit ' .. item.file)
      local bufnr = vim.api.nvim_get_current_buf()
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      for i, line in ipairs(lines) do
        if line:match(item.line) then
          vim.api.nvim_win_set_cursor(0, {i, 0})
          break
        end
      end
    end,
    format = "text",
    layout = { preset = "default" },
  })
end

vim.keymap.set('n', '<leader>oo', markdown_titles, { desc = 'Markdown Titles' })
