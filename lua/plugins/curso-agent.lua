return {
	"suiramdev/cursor-nvim",
	-- Load only when you use the plugin.
	cmd = {
		"CursorAgentToggle",
		"CursorAgentOpen",
		"CursorAgentClose",
		"CursorAgentRestart",
		"CursorAgentResume",
		"CursorAgentListSessions",
		"CursorAgentAddSelection",
		"CursorAgentFixErrorAtCursor",
		"CursorAgentFixErrorAtCursorInNewSession",
		"CursorAgentAddVisualSelectionToNewSession",
		"CursorAgentQuickEdit",
	},
	keys = {
		{ "<leader>at", "<Cmd>CursorAgentToggle<CR>", desc = "Cursor Agent: toggle" },
		{ "<leader>ao", "<Cmd>CursorAgentOpen<CR>", desc = "Cursor Agent: open" },
		{ "<leader>ac", "<Cmd>CursorAgentClose<CR>", desc = "Cursor Agent: close" },
		{ "<leader>ar", "<Cmd>CursorAgentRestart<CR>", desc = "Cursor Agent: restart (new session)" },
		{ "<leader>aR", "<Cmd>CursorAgentResume<CR>", desc = "Cursor Agent: resume last session" },
		{ "<leader>as", "<Cmd>CursorAgentListSessions<CR>", desc = "Cursor Agent: list sessions" },
		{ "<leader>af", "<Cmd>CursorAgentFixErrorAtCursor<CR>", desc = "Cursor Agent: fix error at cursor" },
		{ "<leader>aA", "<Cmd>CursorAgentFixErrorAtCursorInNewSession<CR>", desc = "Cursor Agent: new session + fix error" },
		{ "<leader>aa", "<Cmd>CursorAgentAddSelection<CR>", desc = "Cursor Agent: add selection", mode = "x" },
		{
			"<leader>aE",
			"<Cmd>CursorAgentAddVisualSelectionToNewSession<CR>",
			desc = "Cursor Agent: new session + add selection",
			mode = "x",
		},
		{ "<leader>aq", "<Cmd>CursorAgentQuickEdit<CR>", desc = "Cursor Agent: quick edit selection", mode = "x" },
	},
	opts = {
		command = { "agent" },
		auto_insert = true,
		notify = true,
		path = { relative_to_cwd = true },
		float = { width = 0.9, height = 0.8, border = "rounded" },
	},
	config = function(_, opts)
		if vim.fn.executable(opts.command[1]) ~= 1 then
			vim.notify(
				("cursor-agent.nvim: `%s` not found in $PATH"):format(opts.command[1]),
				vim.log.levels.WARN
			)
			return
		end
		require("cursor_agent").setup(opts)
	end,
}
