-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
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
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = 'plugins.colorscheme' },
    { import = 'plugins.mini' },
    { import = 'plugins.misc' },
    { import = 'plugins.telescope' },
    { import = 'plugins.nvim-ufo' },
    { import = 'plugins.dial-nvim' },
    { import = 'plugins.obsidian-nvim' },
    { import = 'plugins.nvim-cmp' },
    { import = 'plugins.lsp' },
    { import = 'plugins.telescope' },
    { import = 'plugins.treesitter' },
    { import = 'plugins.wip' },
    { import = 'plugins.snacks' },
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Basic Neovim settings
vim.o.ambiwidth = 'single'
vim.o.autochdir = false
vim.o.autoindent = true
vim.o.conceallevel = 2
vim.o.encoding = 'utf-8'
vim.o.expandtab = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.matchtime = 1
vim.o.modeline = true
vim.o.number = true
vim.o.relativenumber = false
vim.o.shiftwidth = 4
vim.o.showmatch = true
vim.o.signcolumn = 'yes'
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.undodir = vim.fn.stdpath('cache') .. '/undo'
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.visualbell = true
vim.o.wrap = true
vim.opt.clipboard:append { 'unnamedplus' }
vim.scriptencoding = 'utf-8'
-- Leader key
vim.g.mapleader = ' '

vim.api.nvim_set_keymap('n', ':', ';', { noremap = true })
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('v', ':', ';', { noremap = true })
vim.api.nvim_set_keymap('v', ';', ':', { noremap = true })

vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohl<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 's', '', { noremap = true })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlights' })

-- Terminal mappings
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

