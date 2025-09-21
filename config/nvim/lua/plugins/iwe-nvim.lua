return {
  'iwe-org/iwe.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',  -- Required
  },
  config = function()
    require('iwe').setup({
      lsp = {
        cmd = { "iwes" },
        name = "iwes",
        debounce_text_changes = 500,
        auto_format_on_save = true
      },
      mappings = {
        enable_markdown_mappings = true,
        enable_telescope_keybindings = false,
        enable_lsp_keybindings = false,
        leader = "<leader>",
        localleader = "<localleader>"
      },
      telescope = {
        enabled = true,
        setup_config = true,
        load_extensions = { "ui-select", "emoji" }
      }
    })
  end
}
