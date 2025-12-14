return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    event = "InsertEnter",
    build = "make install_jsregexp",
    opts = {
        history = true,
        updateevents = "TextChanged,TextChangedI",
    },
    config = function(_, opts)
        local ls = require("luasnip")
        local s = ls.snippet
        local i = ls.insert_node
        local t = ls.text_node
        local events = require("luasnip.util.events")
        local fmt = require("luasnip.extras.fmt").fmt

        ls.setup(opts)

        -- markdown fenced shell block
        ls.add_snippets("markdown", {
            s(
                "bash",
                fmt(
                    "```bash\n{}\n```",
                    { i(1, "カーソル") }
                )
            ),
            s(
                "code",
                fmt(
                    "```\n{}\n```",
                    { i(1, "カーソル") }
                )
            ),
            s(
                "codenorm",
                { t({ "```", "カーソルはここだけど、ノーマルモードにしたい", "```" }) },
                {
                    callbacks = {
                        [-1] = {
                            [events.enter] = function()
                                vim.schedule(function()
                                    vim.cmd("stopinsert")
                                end)
                            end,
                        },
                    },
                }
            ),
        })
    end,
}
