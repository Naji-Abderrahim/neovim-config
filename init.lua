-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
require("config.options")


vim.api.nvim_create_user_command("ShowPopup", function()
	require("myplugin").setup()
end, {})

