return {
	'stevearc/oil.nvim',
	opts = {},
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	lazy = false,
	config = function()
		require("oil").setup({
			columns = {
				"icon",
				"size",
			},
			view_options = {
				show_hidden = true,
			},
		})
	end,
}
