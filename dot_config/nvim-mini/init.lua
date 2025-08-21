-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Neovim Basic settings
later(function()
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
  vim.o.shiftwidth = 2
  vim.o.showmatch = true
  vim.o.signcolumn = 'yes'
  vim.o.smartcase = true
  vim.o.smartindent = true
  vim.o.softtabstop = 2
  vim.o.tabstop = 2
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
end)

-- mini.basics
now(function()
  require('mini.basics').setup({
    options = {
      extra_ui = true,
    },
    mappings = {
      option_toggle_prefix = 'm',
    },
  })
end)

-- mini.misc
now(function()
  require('mini.misc').setup()
  -- ファイルを開いたときに直前のカーソル位置に戻す
  MiniMisc.setup_restore_cursor()
end)

-- mini.icons
now(function()
  require('mini.icons').setup()
end)

-- mini.statusline
now(function()
  require('mini.statusline').setup()
  vim.opt.laststatus = 2
  vim.opt.cmdheight = 2
end)

-- mini.notify
now(function()
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify({})
  -- 過去のnotifyを見直す
  -- https://zenn.dev/kawarimidoll/books/6064bf6f193b51/viewer/b5a24a
  vim.api.nvim_create_user_command('NotifyHistory', function()
    MiniNotify.show_history()
  end, { desc = 'Show notify history' })
end)

-- Color Scheme
now(function()
  vim.cmd.colorscheme('minischeme')
  --stylua: ignore
  palette = {
    bg_edge2 = '#0b060e', bg_edge = '#1a141d', bg = '#262029', bg_mid = '#423b45', bg_mid2 = '#5e5762',
    fg_edge2 = '#f3f1e9', fg_edge = '#e5e3db', fg = '#d7d5cd', fg_mid = '#b7b5ad', fg_mid2 = '#97958e',

    accent = '#e4caf1', accent_bg = '#3a0f2f',

    red    = '#f1c6e2', red_bg    = '#3a0f2f',
    orange = '#fac6c1', orange_bg = '#410d0d',
    yellow = '#efcfab', yellow_bg = '#492c00',
    green  = '#d3daad', green_bg  = '#323700',
    cyan   = '#b3d1b6', cyan_bg   = '#003c24',
    azure  = '#a7e1e8', azure_bg  = '#004b51',
    blue   = '#b8d9fc', blue_bg   = '#00284a',
    purple = '#d7cef9', purple_bg = '#261844',
  }
  require('mini.hues').apply_palette(palette)
end)

-- オペレータ追加
-- mini.operators
-- https://zenn.dev/kawarimidoll/books/6064bf6f193b51/viewer/eacaef
later(function()
  require('mini.operators').setup({
    replace = { prefix = 'R' },
    exchange = { prefix = 'g/' },
  })

  vim.keymap.set('n', 'RR', 'R', { desc = 'Replace mode' })
end)

-- markdown preview
later(function()
  add('skanehira/preview-markdown.vim')
end)

-- ハイライト追加
-- mini.hipatterns, mini.extra
later(function()
  vim.api.nvim_set_hl(0, 'MiniHipatternsNext', { fg = '#000000', bg = '#EC4CE6', bold = true })
  vim.api.nvim_set_hl(0, 'MiniHipatternsDone', { fg = '#000000', bg = '#F296B2', bold = true })
  vim.api.nvim_set_hl(0, 'MiniHipatternsWait', { fg = '#000000', bg = '#FFB400', bold = true })
  vim.api.nvim_set_hl(0, 'MiniHipatternsWill', { fg = '#000000', bg = '#A77563', bold = true })
  local hipatterns = require('mini.hipatterns')
  local hi_words = require('mini.extra').gen_highlighter.words
  hipatterns.setup({
    highlighters = {
      todo = hi_words({ 'TODO' }, 'MiniHipatternsTodo'),
      wip  = hi_words({ 'WIP' }, 'MiniHipatternsHack'),
      done = hi_words({ 'DONE' }, 'MiniHipatternsDone'),
      sche = hi_words({ 'SCHE' }, 'MiniHipatternsNote'),
      next = hi_words({ 'NEXT' }, 'MiniHipatternsNext'),
      wait = hi_words({ 'WAIT' }, 'MiniHipatternsWait'),
      will = hi_words({ 'WILL' }, 'MiniHipatternsWill'),
      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)

-- カーソル行を見やすく
-- mini.cursorword
later(function()
  require('mini.cursorword').setup()
end)

-- ファイル操作
-- mini.files
now(function()
  require('mini.files').setup()

  vim.api.nvim_create_user_command(
    'Files',
    function()
      MiniFiles.open()
    end,
    { desc = 'Open file exproler' }
  )
  vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<cr>', { desc = 'Open file explorer' })
end)

-- fuzzy finder
-- telescope.nvim
later(function()
  add({
    source = 'nvim-telescope/telescope.nvim',
    checkout = '0.1.8',
    depends = {
      'nvim-lua/plenary.nvim'
    }
  })
  -- Using Lua functions
  local builtin = require('telescope.builtin')
  local actions = require('telescope.actions')
  vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
  vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Telescope live grep' })
  vim.keymap.set('n', '<leader>b', builtin.buffers, { noremap = true, silent = true, desc = "Telescope buffers" })

  require('telescope').setup {
    defaults = {
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer,
        },
        n = {
          ["<c-d>"] = actions.delete_buffer,
          ["dd"] = actions.delete_buffer,
        },
      },
    },
  }
end)

-- telescope.nvim拡張
-- telescope-markdown-frontmatter.nvim
later(function()
  add({
    source = "tkancf/telescope-markdown-frontmatter.nvim",
    depends = {
      'nvim-telescope/telescope.nvim',
    }
  })
  -- Search specific fields
  vim.keymap.set("n", "<leader>o", function()
    require("telescope").extensions.markdown_frontmatter.title()
  end, { desc = "Telescope Obsidian Title" })
end)

-- タブみたいにバッファ一覧表示
-- mini.tabline
later(function()
  require('mini.tabline').setup()
end)

-- 自動ペア入力
-- mini.pairs
later(function()
  require('mini.pairs').setup()
end)

-- 括弧系のオペレーター追加
-- mini.surround
later(function()
  require('mini.surround').setup()
end)

-- テキストオブジェクト追加
-- mini.ai
later(function()
  local gen_ai_spec = require('mini.extra').gen_ai_spec
  require('mini.ai').setup({
    custom_textobjects = {
      B = gen_ai_spec.buffer(),
      D = gen_ai_spec.diagnostic(),
      I = gen_ai_spec.indent(),
      L = gen_ai_spec.line(),
      N = gen_ai_spec.number(),
      J = { { '()%d%d%d%d%-%d%d%-%d%d()', '()%d%d%d%d%/%d%d%/%d%d()' } }
    },
  })
end)

-- git diff表示
-- mini.diff
later(function()
  require('mini.diff').setup()
end)

-- git コマンド追加
-- mini.git
later(function()
  require('mini.git').setup()
  vim.keymap.set({ 'n', 'x' }, '<space>gs', MiniGit.show_at_cursor, { desc = 'Show at cursor' })
end)

-- キーマップ表示
-- mini.clue
later(function()
  local function mode_nx(keys)
    return { mode = 'n', keys = keys }, { mode = 'x', keys = keys }
  end
  local clue = require('mini.clue')
  clue.setup({
    triggers = {
      -- Leader triggers
      mode_nx('<leader>'),

      -- Built-in completion
      { mode = 'i', keys = '<c-x>' },

      -- `g` key
      mode_nx('g'),

      -- Marks
      mode_nx("'"),
      mode_nx('`'),

      -- Registers
      mode_nx('"'),
      { mode = 'i', keys = '<c-r>' },
      { mode = 'c', keys = '<c-r>' },

      -- Window commands
      { mode = 'n', keys = '<c-w>' },

      -- bracketed commands
      { mode = 'n', keys = '[' },
      { mode = 'n', keys = ']' },

      -- `z` key
      mode_nx('z'),

      -- surround
      mode_nx('s'),

      -- text object
      { mode = 'x', keys = 'i' },
      { mode = 'x', keys = 'a' },
      { mode = 'o', keys = 'i' },
      { mode = 'o', keys = 'a' },

      -- option toggle (mini.basics)
      { mode = 'n', keys = 'm' },
    },

    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      clue.gen_clues.builtin_completion(),
      clue.gen_clues.g(),
      clue.gen_clues.marks(),
      clue.gen_clues.registers({ show_contents = true }),
      clue.gen_clues.windows({ submode_resize = true, submode_move = true }),
      clue.gen_clues.z(),
    },
  })
end)

-- session管理
-- mini.sessions
now(function()
  require('mini.sessions').setup()

  local function is_blank(arg)
    return arg == nil or arg == ''
  end
  local function get_sessions(lead)
    -- ref: https://qiita.com/delphinus/items/2c993527df40c9ebaea7
    return vim
    .iter(vim.fs.dir(MiniSessions.config.directory))
    :map(function(v)
      local name = vim.fs.basename(v)
      return vim.startswith(name, lead) and name or nil
    end)
    :totable()
  end
  vim.api.nvim_create_user_command('SessionWrite', function(arg)
    local session_name = is_blank(arg.args) and vim.v.this_session or arg.args
    if is_blank(session_name) then
      vim.notify('No session name specified', vim.log.levels.WARN)
      return
    end
    vim.cmd('%argdelete')
    MiniSessions.write(session_name)
  end, { desc = 'Write session', nargs = '?', complete = get_sessions })

  vim.api.nvim_create_user_command('SessionDelete', function(arg)
    MiniSessions.select('delete', { force = arg.bang })
  end, { desc = 'Delete session', bang = true })

  vim.api.nvim_create_user_command('SessionLoad', function()
    MiniSessions.select('read', { verbose = true })
  end, { desc = 'Load session' })

  vim.api.nvim_create_user_command('SessionEscape', function()
    vim.v.this_session = ''
  end, { desc = 'Escape session' })

  vim.api.nvim_create_user_command('SessionReveal', function()
    if is_blank(vim.v.this_session) then
      vim.print('No session')
      return
    end
    vim.print(vim.fs.basename(vim.v.this_session))
  end, { desc = 'Reveal session' })
end)

-- 起動画面
-- mini.starter
now(function()
  require('mini.starter').setup()
end)

-- [ ] の拡張
-- mini.bracketed
later(function()
  require('mini.bracketed').setup()
end)
-- 補完
-- nvim-cmp
now(function()
  add('hrsh7th/nvim-cmp')
  -- nvim-cmp の依存プラグイン
  add('hrsh7th/vim-vsnip')
  add('hrsh7th/cmp-nvim-lsp')
  add('hrsh7th/cmp-buffer')
  add('hrsh7th/cmp-path')
  add('hrsh7th/cmp-cmdline')

  -- nvim-cmp 本体と設定
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'buffer' },
    }),
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
  })

  -- cmdline設定
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

end)

-- Markdownメモ
-- obsidian.nvim
now(function()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
      add({ 
        source =  'obsidian-nvim/obsidian.nvim',
        depends = {
          'nvim-telescope/telescope.nvim',
          'nvim-lua/plenary.nvim',

        },
      })
      vault_path = os.getenv("OBSIDIAN_VAULT_PATH")

      if vault_path == nil then
        vault_path = "~/src/github.com/tkancf/tkancf.com/content/"
      end

      require("obsidian").setup {
        legacy_commands = false,
        ui = {
          enable = false
        },
        attachments = {
          img_folder = "assets", -- This is the default
          img_text_func = function(client, path)
            path = client:vault_relative_path(path) or path
            return string.format("![%s](%s)", path.name, path)
          end,
        },
        workspaces = {
          {
            name = "memo",
            path = vault_path,
          },
        },
        completion = {
          nvim_cmp = true,
          min_chars = 2,
        },
        preferred_link_style = "markdown",
        daily_notes = {
          folder = "",
          date_format = "%Y-%m",
          template = nil
        },
        picker = {
          -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
          name = "telescope.nvim",
          -- Optional, configure key mappings for the picker. These are the defaults.
          -- Not all pickers support all mappings.
          note_mappings = {
            -- Create a new note from your query.
            new = "<C-x>",
            -- Insert a link to the selected note.
            insert_link = "<C-l>",
          },
          tag_mappings = {
            -- Add tag(s) to current note.
            tag_note = "<C-x>",
            -- Insert a tag at the current location.
            insert_tag = "<C-l>",
          },
        },
        ---@return string
        note_id_func = function()
          -- Generate a unique ID YYYYMMDDHHMMSS format
          if vault_path == nil then
            return "blog/" .. tostring(os.date("%Y%m%d%H%M%S"))
          else
            return tostring(os.date("%Y%m%d%H%M%S"))
          end
        end,
        ---@return table
        note_frontmatter_func = function(note)
          if note.title then
            note:add_alias(note.title)
          end
          local created_time = os.date("%Y-%m-%d %H:%M") -- ISO 8601 format
          local updated_time = created_time              -- Initially, created and updated times are the same
          -- Initialize the frontmatter table
          local out = {
            id = note.id,
            title = note.title,
            aliases = note.aliases,
            description = note.title,
            tags = note.tags,
            created = created_time,
            updated = updated_time
          }

          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
              out[k] = v
            end
            if note.metadata.created then out.created = note.metadata.created end
            if note.metadata.updated then out.updated = note.metadata.updated end
          end

          return out
        end,

        ---@param url string
        follow_url_func = function(url)
          vim.fn.jobstart({ "open", url }) -- Mac OS
          -- vim.fn.jobstart({"xdg-open", url})  -- linux
        end,
      }
    end
  })
  -- Key map
  vim.api.nvim_create_autocmd("User", {
    pattern = "ObsidianNoteEnter",
    callback = function(ev)
      vim.keymap.set("n", "<leader>ch", "<cmd>Obsidian toggle_checkbox<cr>", {
        buffer = ev.buf,
        desc = "Toggle checkbox",
      })
    end,
  })
end)

-- treesitter
-- nvim-treesitter
later(function()
  add({
    source = 'https://github.com/nvim-treesitter/nvim-treesitter',
    hooks = {
      post_checkout = function()
        vim.cmd.TSUpdate()
      end
    },
  })
  ---@diagnostic disable-next-line: missing-fields
  require('nvim-treesitter.configs').setup({
    -- auto-install parsers
    ensure_installed = { 'lua', 'vim', 'markdown' },
    highlight = { enable = true },
  })
end)

-- LSP
-- nvim-lsp
later(function()
  add('neovim/nvim-lspconfig')
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  lspconfig.gopls.setup{
    capabilities = capabilities,
  }
  lspconfig.lua_ls.setup{
    capabilities = capabilities,
  }
  lspconfig.ts_ls.setup{
    capabilities = capabilities,
  }
  vim.keymap.set('n', 'gD', vim.diagnostic.open_float, { desc = 'LSP Diagnostic'})
end)

-- 画像表示
-- image.nvim
later(function()
  add("3rd/image.nvim")
  require("image").setup({
    backend = "kitty",
    processor = "magick_cli", -- or "magick_rock"
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        only_render_image_at_cursor_mode = "popup",
        floating_windows = false, -- if true, images will be rendered in floating markdown windows
        filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
      },
      neorg = {
        enabled = true,
        filetypes = { "norg" },
      },
      typst = {
        enabled = true,
        filetypes = { "typst" },
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
    window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
    editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
    tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
  })
end)

-- C-a, C-xの増強
-- dial.nvim
later(function()
  add('monaqa/dial.nvim')
  local augend = require("dial.augend")
  require("dial.config").augends:register_group({
    default = {
      augend.integer.alias.decimal, -- 整数（10進数）の増減
      augend.integer.alias.hex,     -- 整数（16進数）の増減
      augend.date.alias["%Y/%m/%d"], -- 日付の増減
      augend.constant.alias.bool,  -- true/false のトグル
      -- Default task cycle: TODO → WIP → DONE
      augend.constant.new{
        elements = {"TODO", "WIP", "DONE"},
        word = true,
        cyclic = false,
      },
      augend.constant.new{
        elements = {"WAIT", "TODO"},
        word = true,
        cyclic = false,
      },
      augend.constant.new{
        elements = {"NEXT", "TODO"},
        word = true,
        cyclic = false,
      },
      -- Schedule cycle: SCHE → WIP
      augend.constant.new{
        elements = {"SCHE", "WIP"},
        word = true,
        cyclic = false,
      },
    },
  })

  vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
  vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
  vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
  vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
  vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
  vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
end)

-- fold表示の強化
-- nvim-ufo
later(function()
  add({
    source = 'kevinhwang91/nvim-ufo',
    depends = {
      'kevinhwang91/promise-async'
    }
  })
  vim.o.foldcolumn = '1' -- '0' is not bad
  vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true

  -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
  vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
  local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' ↙%d'):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, {chunkText, hlGroup})
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
  end
  require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
      return {'treesitter', 'indent'}
    end,
    fold_virt_text_handler = handler
  })
end)

-- * の機能強化
-- lasterisk.nvim
later(function()
  add('rapan931/lasterisk.nvim')
  local lasterisk = require("lasterisk")
  vim.keymap.set('n', '*',  function() lasterisk.search() end)
  vim.keymap.set('v', '*',  function() lasterisk.search({ is_whole = false }) end)
  vim.keymap.set('n', 'g*', function() lasterisk.search({ is_whole = false }) end)
  vim.keymap.set('x', 'g*', function() lasterisk.search({ is_whole = false }) end)
end)

-- Markdown tableの補助
-- vim-maketable
later(function()
  add('mattn/vim-maketable')
end)

-- QuickFix listを編集可能にする
-- vim-qfreplace
later(function()
  add('thinca/vim-qfreplace')
end)

-- Key map
later(function()
  vim.api.nvim_set_keymap('n', ':', ';', { noremap = true })
  vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })
  vim.api.nvim_set_keymap('v', ':', ';', { noremap = true })
  vim.api.nvim_set_keymap('v', ';', ':', { noremap = true })

  vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohl<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 's', '', { noremap = true })
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlights' })

  -- Terminal mappings
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
end)
