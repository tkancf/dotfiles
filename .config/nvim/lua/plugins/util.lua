return {
    {
        'https://github.com/adelarsq/image_preview.nvim',
        ft = 'markdown',
        --event = 'VeryLazy',
    },
    {
        'https://github.com/cohama/lexima.vim',
        event = 'BufRead',
        config = function()
            vim.g.lexima_enable_space_rules = 0
        end,
    },
    {
        'https://github.com/rbtnn/vim-ambiwidth'
    },
    {
        'https://github.com/thinca/vim-qfreplace'
    },
    {
        'https://github.com/yuki-yano/lexima-alter-command.vim',
        dependencies = {
            'https://github.com/cohama/lexima.vim'
        },
        event = 'BufRead',
        config = function()
            vim.cmd [[
                LeximaAlterCommand obw ObsidianWorkspace
                LeximaAlterCommand obd ObsidianDailies
                LeximaAlterCommand obt ObsidianToday
                LeximaAlterCommand obe ObsidianExtractNote
            ]]
        end,
    },
    {
        'https://github.com/machakann/vim-sandwich',
    },
    {
        'https://github.com/lambdalisue/gin.vim',
        dependencies = {
            'https://github.com/vim-denops/denops.vim',
        },
    },
    {
        'https://github.com/monaqa/dial.nvim',
        config = function()
            vim.keymap.set("n", "<C-a>", function()
                require("dial.map").manipulate("increment", "normal")
            end)
            vim.keymap.set("n", "<C-x>", function()
                require("dial.map").manipulate("decrement", "normal")
            end)
            vim.keymap.set("n", "g<C-a>", function()
                require("dial.map").manipulate("increment", "gnormal")
            end)
            vim.keymap.set("n", "g<C-x>", function()
                require("dial.map").manipulate("decrement", "gnormal")
            end)
            vim.keymap.set("v", "<C-a>", function()
                require("dial.map").manipulate("increment", "visual")
            end)
            vim.keymap.set("v", "<C-x>", function()
                require("dial.map").manipulate("decrement", "visual")
            end)
            vim.keymap.set("v", "g<C-a>", function()
                require("dial.map").manipulate("increment", "gvisual")
            end)
            vim.keymap.set("v", "g<C-x>", function()
                require("dial.map").manipulate("decrement", "gvisual")
            end)
        end,
    },
    {
        'https://github.com/haya14busa/vim-asterisk',
        config = function()
            local opts = { noremap = true, silent = true }

            vim.api.nvim_set_keymap('', '*', '<Plug>(asterisk-z*)', opts)
            vim.api.nvim_set_keymap('', '#', '<Plug>(asterisk-z#)', opts)
            vim.api.nvim_set_keymap('', 'g*', '<Plug>(asterisk-gz*)', opts)
            vim.api.nvim_set_keymap('', 'g#', '<Plug>(asterisk-gz#)', opts)
        end
    },
    {
        'https://github.com/tani/dmacro.nvim',
        config = function()
            vim.keymap.set({ "i", "n" }, '<C-t>', '<Plug>(dmacro-play-macro)')
        end
    },
    {
        "vhyrro/luarocks.nvim",
        enabled = false,
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
            rocks = { "magick" },
        },
    },
    {
        "3rd/image.nvim",
        enabled = false,
        config = function()
            require("image").setup({
                backend = "kitty",
                integrations = {
                    markdown = {
                        enabled = true,
                        clear_in_insert_mode = true,
                        download_remote_images = true,
                        only_render_image_at_cursor = false,
                        filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                        resolve_image_path = function(document_path, image_path, fallback)
                            return fallback(document_path, image_path)
                        end
                    },
                    html = {
                        enabled = false,
                    },
                    css = {
                        enabled = false,
                    },
                },
                max_width = nil,
                max_height = nil,
                max_width_window_percentage = nil,
                max_height_window_percentage = 50,
                window_overlap_clear_enabled = false,                                               -- toggles images when windows are overlapped
                window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
                editor_only_render_when_focused = false,                                            -- auto show/hide images when the editor gains/looses focus
                tmux_show_only_in_active_window = false,                                            -- auto show/hide images in the correct Tmux window (needs visual-activity off)
                hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
            })
        end
    },
}
