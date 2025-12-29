return {
    'https://github.com/nvim-mini/mini.hipatterns',
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
}
