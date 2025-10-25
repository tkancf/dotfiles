return {
  'https://github.com/echasnovski/mini.nvim',
  config = function()
    -- mini.operators
    require('mini.operators').setup({
      replace = { prefix = 'R' },
      exchange = { prefix = 'g/' },
    })
    vim.keymap.set('n', 'RR', 'R', { desc = 'Replace mode' })

    -- 括弧系のオペレーター追加
    -- mini.surround
    require('mini.surround').setup()

    -- テキストオブジェクト追加
    -- mini.ai
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
  end,
}
