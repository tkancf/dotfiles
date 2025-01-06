require('basic')

-- lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

-- My plugins
-- vim.api.nvim_set_keymap('n', '<leader>oo', "<cmd>lua require('markdown_title_picker').open_markdown_by_title()<CR>",
--     { noremap = true, silent = true })

require('markdown_highlights').setup()
require('plugins.tkancf.markdown_title_picker').setup()
