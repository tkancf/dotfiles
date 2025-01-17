return {
  {
    'https://github.com/nvim-lua/plenary.nvim',
    lazy = true,
  },
  {
    'https://github.com/adelarsq/image_preview.nvim',
    ft = 'markdown',
  },
  {
    'https://github.com/cohama/lexima.vim',
    event = { 'CmdlineEnter', 'InsertEnter' },
    lazy = true,
    config = function()
      vim.g.lexima_enable_space_rules = 0
    end,
  },
  {
    'https://github.com/rbtnn/vim-ambiwidth',
    event = { 'VimEnter' },
  },
  {
    'https://github.com/thinca/vim-qfreplace',
    event = { 'CmdlineEnter' },
  },
  {
    'https://github.com/yuki-yano/lexima-alter-command.vim',
    dependencies = {
      'https://github.com/cohama/lexima.vim'
    },
    event = { 'CmdlineEnter' },
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
    enabled = false,
  },
  {
    'https://github.com/lambdalisue/gin.vim',
    event = { 'BufRead' },
  },
  {
    'https://github.com/vim-denops/denops.vim',
    event = { 'BufRead' },
  },
  {
    'https://github.com/monaqa/dial.nvim',
    keys = { "<C-a>", "<C-x>", "g<C-a>", "g<C-x>" },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal, -- 整数（10進数）の増減
          augend.integer.alias.hex,     -- 整数（16進数）の増減
          augend.date.alias["%Y/%m/%d"], -- 日付の増減
          augend.constant.alias.bool,  -- true/false のトグル
        },
      })

      vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
      vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
      vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
      vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
      vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
      vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
    end,
  },
  {
    'https://github.com/haya14busa/vim-asterisk',
    keys = { '*', '#', 'g*', 'g#' },
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
    event = { 'InsertEnter', 'CursorMoved' },
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
