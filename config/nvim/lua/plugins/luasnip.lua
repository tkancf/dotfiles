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
        })

        -- bash
        ls.add_snippets("sh", {
            s(
                "bashmain",
                fmt([[
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

{}
]], { i(1, "# your code") })
            ),
        })

        -- Go
        ls.add_snippets("go", {
            s(
                "gom",
                fmt([[
package main

import "fmt"

func main() {{
\t{}
}}
]], { i(1, [[fmt.Println("hello")]]) })
            ),
            s(
                "got",
                fmt([[
package {}

import "testing"

func Test{}(t *testing.T) {{
\t{}
}}
]], { i(1, "package_name"), i(2, "Name"), i(3, "// TODO") })
            ),
        })

        -- Python
        ls.add_snippets("python", {
            s(
                "pymain",
                fmt([[
def main():
    {}


if __name__ == "__main__":
    main()
]], { i(1, "pass") })
            ),
        })
    end,
}
