return {
	"robitx/gp.nvim",
	config = function()
		local function keymapOptions(desc)
			return {
				noremap = true,
				silent = true,
				nowait = true,
				desc = "GPT prompt " .. desc,
			}
		end
		local conf = {
			providers = {
				copilot = {
					endpoint = "https://api.githubcopilot.com/chat/completions",
					secret = {
						"bash",
						"-c",
						"cat ~/.config/github-copilot/apps.json | sed -e 's/.*oauth_token...//;s/\\\".*//'"
					}
				},
			},

			agents = {
				{
					name = "CopilotGPT",
					provider = "copilot",
					chat = true,
					command = true,
					model = { model = "gpt-4" },
					system_prompt = "You are GitHub Copilot integrated into Neovim.",
				},
			},

		}
		require("gp").setup(conf)

		vim.keymap.set("n", "<leader>g", "<cmd>GpChatToggle<cr>", keymapOptions("New Chat"))
		vim.keymap.set("n", "<leader>ga", "<cmd>GpAppend<cr>", keymapOptions("New Chat"))
		vim.keymap.set("n", "<leader>gf", "<cmd>GpPopup<cr>", keymapOptions("New Chat"))
	end,
}
