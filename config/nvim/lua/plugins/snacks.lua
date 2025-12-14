return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = false },
        indent = { enabled = true },
        input = { enabled = true },
        image = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        picker = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = false },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        styles = {
            notification = {
                -- wo = { wrap = true } -- Wrap notifications
            }
        }
    },
    keys = {
        -- よく使う
        { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
        { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
        { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
        -- buffer
        { "<leader>bb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        { "<leader>b/",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
        { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
        { "<leader>fe",      function() Snacks.explorer() end,                                       desc = "File Explorer" },
        { "<leader>bl",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
        -- find
        { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
        { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
        { "<leader>fu",      function() Snacks.picker.recent() end,                                  desc = "Recently Used" },
        { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
        { "<leader>fR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
        { "<leader>fw",      function() Snacks.picker.grep_word() end,                               desc = "Find word or visual selection", mode = { "n", "x" } },
        -- git
        { "<leader>gl",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
        { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
        { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
        { "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "Lazygit" },
        -- gh
        { "<leader>gi",      function() Snacks.picker.gh_issue() end,                                desc = "GitHub Issues (open)" },
        { "<leader>gI",      function() Snacks.picker.gh_issue({ state = "all" }) end,               desc = "GitHub Issues (all)" },
        { "<leader>gp",      function() Snacks.picker.gh_pr() end,                                   desc = "GitHub Pull Requests (open)" },
        { "<leader>gP",      function() Snacks.picker.gh_pr({ state = "all" }) end,                  desc = "GitHub Pull Requests (all)" },
        -- search
        { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
        { '<leader>sh',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
        { "<leader>s;",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
        { "<leader>s:",      function() Snacks.picker.commands() end,                                desc = "Commands" },
        { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
        { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
        { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
        { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
        -- LSP
        { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "LSP Goto Definition" },
        { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "LSP Goto Declaration" },
        { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                          desc = "LSP References" },
        { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "LSP Goto Implementation" },
        { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "LSP Goto T[y]pe Definition" },
        { "<leader>lci",     function() Snacks.picker.lsp_incoming_calls() end,                      desc = "LSP Calls Incoming" },
        { "<leader>lco",     function() Snacks.picker.lsp_outgoing_calls() end,                      desc = "LSP Calls Outgoing" },
        { "<leader>lS",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
        { "<leader>lW",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
        { "<leader>ld",      function() Snacks.picker.diagnostics() end,                             desc = "LSP Diagnostics" },
        { "<leader>lD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "LSP Buffer Diagnostics" },
        -- Other
        { "sz",              function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
        { "<leader>..",      function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
        { "<leader>.s",      function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
        { "<leader>n",       function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
        { "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",                    mode = { "n", "v" } },
        { "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
        { "<c-/>",           function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
        { "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",                mode = { "n", "t" } },
        { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",                mode = { "n", "t" } },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                vim.api.nvim_create_user_command("BD", function()
                    Snacks.bufdelete()
                end, { desc = "Delete buffer" })

                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end

                -- Override print to use snacks for `:=` command
                if vim.fn.has("nvim-0.11") == 1 then
                    vim._print = function(_, ...)
                        dd(...)
                    end
                else
                    vim.print = _G.dd
                end

                vim.api.nvim_create_user_command("SnacksHelp", function()
                    Snacks.picker.help()
                end, { desc = "Snacks: Help Pages" })

                vim.api.nvim_create_user_command("SnacksNeovimNews", function()
                    Snacks.win({
                        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                        width = 0.6,
                        height = 0.6,
                        wo = {
                            spell = false,
                            wrap = false,
                            signcolumn = "yes",
                            statuscolumn = " ",
                            conceallevel = 3,
                        },
                    })
                end, { desc = "Open Neovim News" })
            end,
        })
    end,
}
