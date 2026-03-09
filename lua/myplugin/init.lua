local M = {}

State = {
	bufnr = nil,
	win = nil,
}

local create_new_floating_window = function()
	State.bufnr = vim.api.nvim_create_buf(false, true)

	-- buffer configs to remove it from the buffer list after i copy the content
	vim.bo[State.bufnr].buftype = "nofile"
	vim.bo[State.bufnr].bufhidden = "wipe"
	vim.bo[State.bufnr].swapfile = false
	vim.bo[State.bufnr].buflisted = false

	local width = math.floor(vim.o.columns * 0.5)
	local height = 20 -- a predefined height can be modified as needed
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- 4) Open the floating window
	State.win = vim.api.nvim_open_win(State.bufnr, true, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		border = "rounded",
		style = "minimal",
	})
end

local yank_data_to_reg = function()
	local lines = vim.api.nvim_buf_get_lines(State.bufnr, 0, -1, false)
	local text = table.concat(lines, "\n")
	text = '"""\n' .. text .. '"""\n'
	vim.fn.setreg('+', text)
end

local function get_function_under_cursor()
	-- queries to be expanded get all the possible node_names when i need to
	local queries = {
		java = "(method_declaration) @func",
		lua = "(function_declaration) @func",
		others = "(function_definition) @func"
	}

	local ft = vim.bo.filetype
	local exper = nil
	if ft == 'java' then
		exper = queries.java
	elseif ft == 'lua' then
		exper = queries.lua
	else
		exper = queries.others
	end
	local parent_bufnr = vim.api.nvim_get_current_buf()
	local tree = vim.treesitter.get_parser(parent_bufnr, ft):parse()[1]

	if not tree then
		vim.notify("No Tree-sitter parser found for filetype: " .. ft, vim.log.levels.WARN)
		return
	end
	local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
	local current_row = cursor_line - 1

	local query = vim.treesitter.query.parse(ft, exper)

	for id, node, metadata in query:iter_captures(tree:root(), parent_bufnr, current_row) do
		local r1, c1, r2, c2 = node:range()
		if current_row >= r1 and current_row <= r2 then
			return vim.treesitter.get_node_text(node, parent_bufnr)
		end
	end
	return nil
end

local function setup_keymaps()
	-- Setup some custom keymaps
	-- q: quit
	-- Enter (<CR>): to copy this to clipboard "y+"

	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(State.win, true)
	end, { buffer = State.bufnr })

	vim.keymap.set("n", "<CR>", function()
		yank_data_to_reg()
		vim.api.nvim_win_close(State.win, true)
	end, { buffer = State.bufnr })
end

function M.execute_python_code_to_window()
	-- get the current function that is under cursor as a string
	local resulted_node_text = get_function_under_cursor()
	if resulted_node_text == nil then
		vim.notify("Function Not found", vim.log.levels.WARN)
		return
	end

	-- this function will create a new window and assign the bufnr and win to
	-- Global State table
	create_new_floating_window()

	-- setup keymaps for floating window
	setup_keymaps()

	-- main function that executes the python code and copy the rsult into my State.bufnr
	-- for now i m passing it `text` as an argument
	local job_id = vim.fn.jobstart({ "/home/Airs/.bin/code_doc" }, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			if data then
				vim.api.nvim_buf_set_lines(State.bufnr, 0, -1, false, data)
				-- vim.bo[State.bufnr].modifiable = false
			end
		end,
		stdin = "pipe"
	})

	vim.fn.chansend(job_id, resulted_node_text)
	vim.fn.chanclose(job_id, "stdin")
end

function M.setup()
	M.execute_python_code_to_window()
end

return M
