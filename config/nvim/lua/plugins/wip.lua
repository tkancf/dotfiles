return {
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		lazy = false,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			-- "nvim-tree/nvim-web-devicons",
		},
		lazy = false, -- neo-tree will lazily load itself
		config = function()
			vim.keymap.set('n', '<leader>e', '<C-u>:Neotree<CR>', { desc = 'Open file explorer' })
		end,
	},
}
