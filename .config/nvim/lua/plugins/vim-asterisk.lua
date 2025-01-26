return {
  'https://github.com/haya14busa/vim-asterisk',
  keys = { '*', '#', 'g*', 'g#' },
  config = function()
    local opts = { noremap = true, silent = true }

    vim.api.nvim_set_keymap('', '*', '<Plug>(asterisk-z*)', opts)
    vim.api.nvim_set_keymap('', '#', '<Plug>(asterisk-z#)', opts)
    vim.api.nvim_set_keymap('', 'g*', '<Plug>(asterisk-gz*)', opts)
    vim.api.nvim_set_keymap('', 'g#', '<Plug>(asterisk-gz#)', opts)
  end
}
