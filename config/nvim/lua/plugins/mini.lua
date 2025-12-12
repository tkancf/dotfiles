return {
    {
        'https://github.com/nvim-mini/mini.basics',
        enabled = false,
        version = false,
        lazy = false,
        opts = {
            options = { extra_ui = true },
            mappings = { option_toggle_prefix = 'm' },
        },
    },
    {
        'https://github.com/nvim-mini/mini.statusline',
        enabled = true,
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
        version = false,
        opts = {},
    },
    {
        'https://github.com/nvim-mini/mini.operators',
        enabled = false,
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
        enabled = false,
        version = false,
        opts = {},
    },
    {
        'https://github.com/nvim-mini/mini.hipatterns',
        enabled = false,
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
        enabled = false,
        version = false,
        opts = {},
    },
    {
        'https://github.com/nvim-mini/mini.pairs',
        enabled = false,
        version = false,
        opts = {},
    },
    {
        'https://github.com/nvim-mini/mini.surround',
        version = false,
        opts = {},
    },
    {
        'https://github.com/nvim-mini/mini.ai',
        enabled = false,
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
        'https://github.com/nvim-mini/mini.bracketed',
        enabled = false,
        version = false,
        opts = {},
    },
    {
        'https://github.com/nvim-mini/mini.misc',
        enabled = false,
        version = false,
        config = function()
            require('mini.misc').setup_restore_cursor()
        end,
    },
    {
        'https://github.com/nvim-mini/mini.extra',
        enabled = false,
        version = false,
        opts = {},
    },
}
