-- ~/.config/nvim/lua/my_popup_plugin/init.lua
local M = {}

function M.show_popup(text)
	-- 1) Create scratch buffer
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].modifiable = true
	vim.bo[buf].readonly = true
	vim.bo[buf].buftype = "nofile"     -- makes it not associated with any file
	vim.bo[buf].bufhidden = "wipe"     -- automatically removes it when closed
	vim.bo[buf].swapfile = false       -- don't create swap files

	-- 2) Write text into it
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n"))
	vim.bo[buf].modifiable = false

	-- 3) Popup window dimensions
	local width = math.floor(vim.o.columns * 0.5)
	local height = math.min(10, #vim.split(text, "\n"))
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- 4) Open the floating window
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		border = "rounded",
		style = "minimal",
	})

	-- 5) Add keymaps for actions
	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf })

	vim.keymap.set("n", "<CR>", function()
		vim.api.nvim_win_close(win, true)
		vim.notify("You confirmed the text!")
		-- here you can modify current buffer using vim.api.nvim_buf_set_lines(...)
	end, { buffer = buf })

	return win
end

function M.setup()
	vim.api.nvim_create_user_command("ShowPopup", function()
		M.show_popup("Hello from your plugin!\nPress <Enter> to confirm or q to close.")
	end, {})
end

return M

