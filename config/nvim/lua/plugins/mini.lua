return {
  'https://github.com/echasnovski/mini.nvim',
  config = function()
    -- mini.basics
    require('mini.basics').setup({
      options = {
        extra_ui = true,
      },
      mappings = {
        option_toggle_prefix = 'm',
      },
    })

    -- mini.misc
    require('mini.misc').setup_restore_cursor()

    -- mini.statusline
    require('mini.statusline').setup()
    vim.opt.laststatus = 2
    vim.opt.cmdheight = 2

    -- mini.icons
    require('mini.icons').setup()
    -- mini.notify
    vim.notify = require('mini.notify').make_notify({})
    -- 過去のnotifyを見直す
    -- https://zenn.dev/kawarimidoll/books/6064bf6f193b51/viewer/b5a24a
    vim.api.nvim_create_user_command('NotifyHistory', function()
      require('mini.notify').show_history()
    end, { desc = 'Show notify history' })

    -- mini.icons
    require('mini.icons').setup()

    -- mini.operators
    require('mini.operators').setup({
      replace = { prefix = 'R' },
      exchange = { prefix = 'g/' },
    })
    vim.keymap.set('n', 'RR', 'R', { desc = 'Replace mode' })

    -- mini.cursorword
    require('mini.cursorword').setup()

    -- mini.files
    require('mini.files').setup()
    vim.api.nvim_create_user_command(
      'Files',
      function()
        MiniFiles.open()
      end,
      { desc = 'Open file exproler' }
    )
    vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<cr>', { desc = 'Open file explorer' })

    -- mini.hipatterns
    local hipatterns = require('mini.hipatterns')
    -- mini.extra
    local hi_words = require('mini.extra').gen_highlighter.words
    vim.api.nvim_set_hl(0, 'MiniHipatternsNext', { fg = '#000000', bg = '#EC4CE6', bold = true })
    vim.api.nvim_set_hl(0, 'MiniHipatternsDone', { fg = '#000000', bg = '#F296B2', bold = true })
    vim.api.nvim_set_hl(0, 'MiniHipatternsWait', { fg = '#000000', bg = '#FFB400', bold = true })
    vim.api.nvim_set_hl(0, 'MiniHipatternsWill', { fg = '#000000', bg = '#A77563', bold = true })
    hipatterns.setup({
      highlighters = {
        todo = hi_words({ 'TODO' }, 'MiniHipatternsTodo'),
        wip  = hi_words({ 'WIP' }, 'MiniHipatternsHack'),
        done = hi_words({ 'DONE' }, 'MiniHipatternsDone'),
        sche = hi_words({ 'SCHE' }, 'MiniHipatternsNote'),
        next = hi_words({ 'NEXT' }, 'MiniHipatternsNext'),
        wait = hi_words({ 'WAIT' }, 'MiniHipatternsWait'),
        will = hi_words({ 'WILL' }, 'MiniHipatternsWill'),
        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })

    -- タブみたいにバッファ一覧表示
    -- mini.tabline
    require('mini.tabline').setup()

    -- 自動ペア入力
    -- mini.pairs
    require('mini.pairs').setup()

    -- 括弧系のオペレーター追加
    -- mini.surround
    require('mini.surround').setup()

    -- テキストオブジェクト追加
    -- mini.ai
    local gen_ai_spec = require('mini.extra').gen_ai_spec
    require('mini.ai').setup({
      custom_textobjects = {
        B = gen_ai_spec.buffer(),
        D = gen_ai_spec.diagnostic(),
        I = gen_ai_spec.indent(),
        L = gen_ai_spec.line(),
        N = gen_ai_spec.number(),
        J = { { '()%d%d%d%d%-%d%d%-%d%d()', '()%d%d%d%d%/%d%d%/%d%d()' } }
      },
    })

    -- git コマンド追加
    -- mini.git
    require('mini.git').setup()
    vim.keymap.set({ 'n', 'x' }, '<space>gs', MiniGit.show_at_cursor, { desc = 'Show at cursor' })

    -- キーマップ表示
    -- mini.clue
    local function mode_nx(keys)
      return { mode = 'n', keys = keys }, { mode = 'x', keys = keys }
    end
    local clue = require('mini.clue')
    clue.setup({
      triggers = {
        -- Leader triggers
        mode_nx('<leader>'),

        -- Built-in completion
        { mode = 'i', keys = '<c-x>' },

        -- `g` key
        mode_nx('g'),

        -- Marks
        mode_nx("'"),
        mode_nx('`'),

        -- Registers
        mode_nx('"'),
        { mode = 'i', keys = '<c-r>' },
        { mode = 'c', keys = '<c-r>' },

        -- Window commands
        { mode = 'n', keys = '<c-w>' },

        -- bracketed commands
        { mode = 'n', keys = '[' },
        { mode = 'n', keys = ']' },

        -- `z` key
        mode_nx('z'),

        -- surround
        mode_nx('s'),

        -- text object
        { mode = 'x', keys = 'i' },
        { mode = 'x', keys = 'a' },
        { mode = 'o', keys = 'i' },
        { mode = 'o', keys = 'a' },

        -- option toggle (mini.basics)
        { mode = 'n', keys = 'm' },
      },

      clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        clue.gen_clues.builtin_completion(),
        clue.gen_clues.g(),
        clue.gen_clues.marks(),
        clue.gen_clues.registers({ show_contents = true }),
        clue.gen_clues.windows({ submode_resize = true, submode_move = true }),
        clue.gen_clues.z(),
      },
    })

    -- session管理
    -- mini.sessions
    require('mini.sessions').setup()

    local function is_blank(arg)
      return arg == nil or arg == ''
    end
    local function get_sessions(lead)
      -- ref: https://qiita.com/delphinus/items/2c993527df40c9ebaea7
      return vim
      .iter(vim.fs.dir(MiniSessions.config.directory))
      :map(function(v)
        local name = vim.fs.basename(v)
        return vim.startswith(name, lead) and name or nil
      end)
      :totable()
    end
    vim.api.nvim_create_user_command('SessionWrite', function(arg)
      local session_name = is_blank(arg.args) and vim.v.this_session or arg.args
      if is_blank(session_name) then
        vim.notify('No session name specified', vim.log.levels.WARN)
        return
      end
      vim.cmd('%argdelete')
      MiniSessions.write(session_name)
    end, { desc = 'Write session', nargs = '?', complete = get_sessions })

    vim.api.nvim_create_user_command('SessionDelete', function(arg)
      MiniSessions.select('delete', { force = arg.bang })
    end, { desc = 'Delete session', bang = true })

    vim.api.nvim_create_user_command('SessionLoad', function()
      MiniSessions.select('read', { verbose = true })
    end, { desc = 'Load session' })

    vim.api.nvim_create_user_command('SessionEscape', function()
      vim.v.this_session = ''
    end, { desc = 'Escape session' })

    vim.api.nvim_create_user_command('SessionReveal', function()
      if is_blank(vim.v.this_session) then
        vim.print('No session')
        return
      end
      vim.print(vim.fs.basename(vim.v.this_session))
    end, { desc = 'Reveal session' })

    --- 起動画面
    -- mini.starter
    require('mini.starter').setup()

    -- [ ] の拡張
    -- mini.bracketed
    require('mini.bracketed').setup()
  end,
}
