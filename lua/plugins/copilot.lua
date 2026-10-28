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
					accept = "<A-l>",
					dismiss = "<C-]>",
					next = "<A-]>",
					prev = "<A-[>",
				},
			},

			-- copilot_model = "64656",
		})
	end,
}
