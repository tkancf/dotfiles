-- Basic
-- encoding
vim.o.encoding = 'utf-8'
vim.scriptencoding = 'utf-8'
vim.o.ambiwidth = 'single'
vim.o.conceallevel = 0
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.visualbell = true
vim.o.showmatch = true
vim.o.matchtime = 1
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.opt.clipboard:append { 'unnamedplus' }
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('cache') .. '/undo'
vim.o.foldlevel = 1
vim.o.conceallevel = 2
vim.o.autochdir = false
vim.o.modeline = true

-- Set list option to show hidden characters
vim.opt.list = true
vim.opt.listchars = {
    tab = '»-', -- Tabs
    trail = '␣', -- Trailing spaces
    -- eol = '↲', -- End of line
    extends = '»', -- Overflow characters that extend past the right of the screen
    precedes = '«', -- Overflow characters that precede the beginning of the screen
    nbsp = '%', -- Non-breaking space
    -- space = '_' -- Space characters
}

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- remap
vim.g.mapleader = " "
vim.api.nvim_set_keymap('n', 's', '', { noremap = true })
vim.g.maplocalleader = '\\'
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('n', ':', ';', { noremap = true })
vim.api.nvim_set_keymap('v', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('v', ':', ';', { noremap = true })
vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohl<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>t', ':tabnew<CR>', { noremap = true, silent = true })

-- GUI (Neovide)
if vim.g.gui_vimr then
end
