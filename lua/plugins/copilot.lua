return {
	"zbirenbaum/copilot.lua",
	-- requires = {
	-- 	"copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
	-- },
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = false
			},

			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<M-l>",
					dismiss = "<C-]>",
					next = "<M-]>",
					prev = "<M-[>",
				},
			},

			-- copilot_model = "64656",
		})
	end,
}
