return {
  'moonbit-community/moonbit.nvim',
  ft = { 'moonbit' },
  opts = {
    mooncakes = {
      virtual_text = true,
      use_local = true,
    },
    treesitter = {
      enabled = true,
      auto_install = false,
    },
    lsp = {
      native = false,
      on_attach = function(client, bufnr) end,
      capabilities = vim.lsp.protocol.make_client_capabilities(),
    },
    jsonls = {
      settings = {},
    },
  },
  config = function(_, opts)
    require('moonbit').setup(opts)
    local ok, ts = pcall(require, 'nvim-treesitter')
    if ok then
      vim.api.nvim_exec_autocmds('User', { pattern = 'TSUpdate' })
      pcall(ts.install, { 'moonbit' })
    end
  end,
}
