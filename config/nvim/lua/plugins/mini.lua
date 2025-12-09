return {
    {
        'https://github.com/nvim-mini/mini.basics',
        name = 'mini.basics',
        version = false,
        lazy = false,
        opts = {
            options = { extra_ui = true },
            mappings = { option_toggle_prefix = 'm' },
        },
    },
    {
        'https://github.com/nvim-mini/mini.statusline',
        name = 'mini.statusline',
        version = false,
        lazy = false,
        opts = {},
        init = function()
            vim.opt.laststatus = 2
            vim.opt.cmdheight = 2
        end,
    },
    {
        'https://github.com/nvim-mini/mini.icons',
        name = 'mini.icons',
        version = false,
        opts = {},
    },
    {
        'https://github.com/nvim-mini/mini.operators',
        name = 'mini.operators',
        version = false,
        keys = {
            { 'RR', 'R', mode = 'n', desc = 'Replace mode' },
        },
        opts = {
            replace = { prefix = 'R' },
            exchange = { prefix = 'g/' },
        },
    },
    {
        'https://github.com/nvim-mini/mini.cursorword',
        name = 'mini.cursorword',
        version = false,
        opts = {},
    },
    {
        'https://github.com/nvim-mini/mini.hipatterns',
        name = 'mini.hipatterns',
        version = false,
        dependencies = { 'https://github.com/nvim-mini/mini.extra' },
        opts = {},
        config = function(_, opts)
            local hipatterns = require('mini.hipatterns')
            local hi_words = require('mini.extra').gen_highlighter.words
            local colors = {
                TODO = { fg = '#000000', bg = '#ffc0cb', bold = true },
                WIP = { fg = '#000000', bg = '#4169e1', bold = true },
                DONE = { fg = '#FFFFFF', bg = '#696969', bold = true },
                SCHE = { fg = '#000000', bg = '#3cb371', bold = true },
                NEXT = { fg = '#000000', bg = '#afeeee', bold = true },
                WAIT = { fg = '#000000', bg = '#f0e68c', bold = true },
                WILL = { fg = '#000000', bg = '#00ced1', bold = true },
            }

            local highlighters = { hex_color = hipatterns.gen_highlighter.hex_color() }
            for word, hl in pairs(colors) do
                local hl_name = 'MiniHipatterns' .. word
                vim.api.nvim_set_hl(0, hl_name, hl)
                highlighters[string.lower(word)] = hi_words({ word }, hl_name)
            end
            opts.highlighters = highlighters
            require('mini.hipatterns').setup(opts)
        end,
    },
    {
        'https://github.com/nvim-mini/mini.tabline',
        name = 'mini.tabline',
        version = false,
        opts = {},
    },
    {
        'https://github.com/nvim-mini/mini.pairs',
        name = 'mini.pairs',
        version = false,
        opts = {},
    },
    {
        'https://github.com/nvim-mini/mini.surround',
        name = 'mini.surround',
        version = false,
        opts = {},
    },
    {
        'https://github.com/nvim-mini/mini.ai',
        name = 'mini.ai',
        version = false,
        dependencies = { 'https://github.com/nvim-mini/mini.extra' },
        opts = {},
        config = function(_, opts)
            local gen_ai_spec = require('mini.extra').gen_ai_spec
            opts.custom_textobjects = vim.tbl_deep_extend('force', opts.custom_textobjects or {}, {
                B = gen_ai_spec.buffer(),
                D = gen_ai_spec.diagnostic(),
                I = gen_ai_spec.indent(),
                L = gen_ai_spec.line(),
                N = gen_ai_spec.number(),
                J = { { '()%d%d%d%d%-%d%d%-%d%d()', '()%d%d%d%d%/%d%d%/%d%d()' } },
            })
            require('mini.ai').setup(opts)
        end,
    },
    {
        'https://github.com/nvim-mini/mini.sessions',
        name = 'mini.sessions',
        version = false,
        opts = {},
        config = function(_, opts)
            require('mini.sessions').setup(opts)

            local function is_blank(arg)
                return arg == nil or arg == ''
            end
            local function get_sessions(lead)
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
        end,
    },
    {
        'https://github.com/nvim-mini/mini.starter',
        name = 'mini.starter',
        version = false,
        opts = {},
    },
    {
        'https://github.com/nvim-mini/mini.bracketed',
        name = 'mini.bracketed',
        version = false,
        opts = {},
    },
    {
        'https://github.com/nvim-mini/mini.misc',
        name = 'mini.misc',
        version = false,
        config = function()
            require('mini.misc').setup_restore_cursor()
        end,
    },
    {
        'https://github.com/nvim-mini/mini.extra',
        name = 'mini.extra',
        version = false,
        opts = {},
    },
}
