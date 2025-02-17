return {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    lspconfig.gopls.setup{
      capabilities = capabilities,
    }
    lspconfig.lua_ls.setup{
      capabilities = capabilities,
    }
    vim.keymap.set('n', 'gD', vim.diagnostic.open_float, { desc = 'LSP Diagnostic'})
  end,
}
