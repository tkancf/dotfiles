-- 参考: [今からNeovimを始める人のLSP最短設定 (0.11, 2025-10-04現在)](https://zenn.dev/ras96/articles/4d9d9493d29c06)
vim.lsp.enable({
    -- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
    "lua_ls",
    -- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/roc_ls.lua
    "roc_ls",
    -- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/gopls.lua
    "gopls",
})

-- 言語サーバーがアタッチされた時に呼ばれる
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local buf = args.buf

        -- デフォルトで設定されている言語サーバー用キーバインドに設定を追加する
        -- See https://neovim.io/doc/user/lsp.html#lsp-defaults
        -- 言語サーバーのクライアントがLSPで定められた機能を実装していたら設定を追加するという流れ

        if client:supports_method("textDocument/definition") then
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to definition" })
        end

        if client:supports_method("textDocument/hover") then
            vim.keymap.set("n", "<leader>lk",
                function() vim.lsp.buf.hover({ border = "single" }) end,
                { buffer = buf, desc = "Show hover documentation" })
        end

        -- if client:supports_method("textDocument/completion") then
        --     client.server_capabilities.completionProvider.triggerCharacters = chars
        --     client.server_capabilities.completionProvider.triggerCharacters =
        --         vim.split("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.", "")
        --     vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        -- end

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if not client:supports_method("textDocument/willSaveWaitUntil")
            and client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end

        if client:supports_method("textDocument/inlineCompletion") then
            vim.lsp.inline_completion.enable(true, { bufnr = buf })
            vim.keymap.set("i", "<Tab>", function()
                if not vim.lsp.inline_completion.get() then
                    return "<Tab>"
                end
                -- close the completion popup if it's open
                if vim.fn.pumvisible() == 1 then
                    return "<C-e>"
                end
            end, {
                expr = true,
                buffer = buf,
                desc = "Accept the current inline completion",
            })
        end
    end,
})
