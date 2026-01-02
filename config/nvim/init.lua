-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = 'plugins.colorscheme' },
        { import = 'plugins.dial' },
        { import = 'plugins.flash' },
        { import = 'plugins.fyler' },
        { import = 'plugins.gitsigns' },
        { import = 'plugins.lasterisk' },
        { import = 'plugins.mini-hipatterns' },
        { import = 'plugins.mini-cmdline' },
        { import = 'plugins.mini-icons' },
        { import = 'plugins.mini-statusline' },
        { import = 'plugins.mini-surround' },
        { import = 'plugins.nvim-cmp' },
        { import = 'plugins.nvim-insx' },
        { import = 'plugins.nvim-lspconfig' },
        { import = 'plugins.nvim-pasta' },
        { import = 'plugins.nvim-snippy' },
        { import = 'plugins.obsidian' },
        { import = 'plugins.neogit' },
        { import = 'plugins.snacks' },
        { import = 'plugins.bufferline' },
        { import = 'plugins.treesitter' },
        { import = 'plugins.which-key' },
        { import = 'plugins.persistence' },
        { import = 'plugins.quicker' },
        { 'mattn/vim-maketable' },
    },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

-- load lua/config/lsp.lua setting
require('config.lsp')

-- Basic Neovim settings
vim.opt.ambiwidth = 'single'
vim.opt.autochdir = false
vim.opt.autoindent = true
vim.opt.conceallevel = 2
vim.opt.laststatus = 3
vim.opt.cmdheight = 1
vim.opt.encoding = 'utf-8'
vim.opt.expandtab = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.matchtime = 1
vim.opt.modeline = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.autoread = true
vim.opt.undodir = vim.fn.stdpath('cache') .. '/undo'
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.visualbell = true
vim.opt.wrap = true
vim.opt.clipboard:append { 'unnamedplus' }
vim.scriptencoding = 'utf-8'

-- Enable extui if available (Neovim 0.10+)
do
    local ok, extui = pcall(require, 'vim._extui')
    if ok then
        extui.enable({
            enable = true,
            msg = {
                target = 'cmd',
                timeout = 5000,
            },
        })
    end
end

-- Keep jumplist/history per startup directory.
do
    local cwd = vim.fn.getcwd()
    local base = vim.fn.stdpath("state") .. "/shada"
    vim.fn.mkdir(base, "p")
    local name = vim.fn.fnamemodify(cwd, ":t")
    local hash = vim.fn.sha256(cwd):sub(1, 8)
    vim.opt.shadafile = string.format("%s/%s-%s.shada", base, name, hash)
end

-- :と;を入れ替え
vim.api.nvim_set_keymap('n', ':', ';', { noremap = true, desc = "Swap : ;" })
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true, desc = "Swap : ;" })
vim.api.nvim_set_keymap('v', ':', ';', { noremap = true, desc = "Swap : ;" })
vim.api.nvim_set_keymap('v', ';', ':', { noremap = true, desc = "Swap : ;" })

vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohl<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 's', '', { noremap = true })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlights' })

-- Terminal mappings
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- restart後に最後のセッションを復元する
-- 参考: https://blog.atusy.net/2025/12/02/nvim-restart/
vim.keymap.set("n", "ZR", function()
    vim.cmd([[restart +xa lua require("persistence").load({ last = true })]])
end, { desc = 'Restart後に最後のセッションを復元' })

-- 外部更新を検知して自動で再読込
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave", "CursorHold", "CursorHoldI", "BufEnter" }, {
    callback = function()
        if vim.fn.getcmdwintype() ~= "" or vim.api.nvim_get_mode().mode == "c" then
            return
        end
        vim.cmd("checktime")
    end,
})

-- ウィンドウ移動・分割のショートカット
vim.api.nvim_set_keymap('n', 'sl', '<C-w>l', { noremap = true, desc = 'Window left' })
vim.api.nvim_set_keymap('n', 'sh', '<C-w>h', { noremap = true, desc = 'Window right' })
vim.api.nvim_set_keymap('n', 'sj', '<C-w>j', { noremap = true, desc = 'Window down' })
vim.api.nvim_set_keymap('n', 'sk', '<C-w>k', { noremap = true, desc = 'Window up' })
vim.api.nvim_set_keymap('n', 'sv', '<C-w>v', { noremap = true, desc = 'Split window vertical' })
vim.api.nvim_set_keymap('n', 'sn', ']b', { noremap = false, desc = 'Buffer next' })
vim.api.nvim_set_keymap('n', 'sp', '[b', { noremap = false, desc = 'Buffer previous' })

-- Show diagnostics at cursor
vim.keymap.set('n', '<leader>d', function()
    vim.diagnostic.open_float(nil, { border = 'single' })
end, { desc = 'Show diagnostics' })
