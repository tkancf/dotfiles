return {
  "tkancf/narrowing-nvim",
  config = function()
    require("narrowing").setup({
      keymaps = {
        narrow = "<leader>nr",  -- Keymap to narrow selection
        write = "<leader>nw",   -- Keymap to write changes
        quit = "<leader>nq",    -- Keymap to quit without saving
      },
    })
  end,
}
