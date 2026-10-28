-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
require("config.options")


vim.api.nvim_create_user_command("ShowPopup", function()
	require("myplugins.coder_docs").setup()
end, {})

vim.api.nvim_create_user_command("HighlightSelection", function()
	require("myplugins.code_hilighter").highlight_selection()
end, {})

vim.api.nvim_create_user_command("ClearHighlight", function()
	require("myplugins.code_hilighter").clear_highlight()
end, {})

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "java",
-- 	callback = function()
-- 		-- 1. Find the project root
-- 		local root_dir = vim.fs.root(0, { "pom.xml", "build.gradle", ".git" }) or vim.fn.getcwd()
--
-- 		-- 2. Generate a unique workspace path based on the project folder name
-- 		local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
-- 		local workspace_dir = vim.fn.expand("~/.cache/jdtls/workspace/") .. project_name
--
-- 		-- 3. Get the absolute path to Mason's jdtls binary
-- 		local jdtls_bin = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
--
-- 		-- 4. Start the LSP natively with the dynamic command
-- 		vim.lsp.start({
-- 			name = "jdtls",
-- 			cmd = { jdtls_bin, "-data", workspace_dir },
-- 			root_dir = root_dir,
-- 			-- You can add your settings/init_options here if needed
-- 			settings = {
-- 				java = {}
-- 			}
-- 		})
-- 	end
-- })
