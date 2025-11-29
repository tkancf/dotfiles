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

        -- mini.operators
        require('mini.operators').setup({
            replace = { prefix = 'R' },
            exchange = { prefix = 'g/' },
        })
        vim.keymap.set('n', 'RR', 'R', { desc = 'Replace mode' })

        -- mini.cursorword
        require('mini.cursorword').setup()

        -- mini.hipatterns
        local hipatterns = require('mini.hipatterns')
        -- mini.extra
        local hi_words = require('mini.extra').gen_highlighter.words
        vim.api.nvim_set_hl(0, 'MiniHipatternsTODO', { fg = '#000000', bg = '#ffc0cb', bold = true })
        vim.api.nvim_set_hl(0, 'MiniHipatternsWIP', { fg = '#000000', bg = '#4169e1', bold = true })
        vim.api.nvim_set_hl(0, 'MiniHipatternsDONE', { fg = '#FFFFFF', bg = '#696969', bold = true })
        vim.api.nvim_set_hl(0, 'MiniHipatternsSCHE', { fg = '#000000', bg = '#3cb371', bold = true })
        vim.api.nvim_set_hl(0, 'MiniHipatternsNEXT', { fg = '#000000', bg = '#afeeee', bold = true })
        vim.api.nvim_set_hl(0, 'MiniHipatternsWAIT', { fg = '#000000', bg = '#f0e68c', bold = true })
        vim.api.nvim_set_hl(0, 'MiniHipatternsWILL', { fg = '#000000', bg = '#00ced1', bold = true })

        hipatterns.setup({
            highlighters = {
                todo      = hi_words({ 'TODO' }, 'MiniHipatternsTODO'),
                wip       = hi_words({ 'WIP' }, 'MiniHipatternsWIP'),
                done      = hi_words({ 'DONE' }, 'MiniHipatternsDONE'),
                sche      = hi_words({ 'SCHE' }, 'MiniHipatternsNOTE'),
                next      = hi_words({ 'NEXT' }, 'MiniHipatternsNEXT'),
                wait      = hi_words({ 'WAIT' }, 'MiniHipatternsWAIT'),
                will      = hi_words({ 'WILL' }, 'MiniHipatternsWILL'),
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
