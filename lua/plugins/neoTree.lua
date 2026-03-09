return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	lazy = false,                    -- neo-tree will lazily load itselfF.F,
	config = function(_, opts)
		local nt = require("neo-tree")

		nt.setup({
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				-- "document_symbols",
			},
			add_blank_line_at_top = false, -- Add a blank line at the top of the tree.
			auto_clean_after_session_restore = false, -- Automatically clean up broken neo-tree buffers saved in sessions
			clipboard = {
				sync = "global",           -- or "global"/"universal" to share a clipboard for each/all Neovim instance(s), respectively
			},
			close_if_last_window = true,   -- Close Neo-tree if it is the last window left in the tab
			hide_root_node = false,        -- Hide the root node.
			retain_hidden_root_indent = false, -- IF the root node is hidden, keep the indentation anyhow.

			open_files_do_not_replace_types = {},
			open_files_using_relative_paths = false,
			popup_border_style = "rounded",
			use_popups_for_input = false,
				
			  event_handlers = {
				{
				  event = "neo_tree_buffer_enter",
				  handler = function()
					-- vim.opt_local.number = true
					vim.opt_local.relativenumber = true
				  end,
				},
			},

			window = {
				preserve_window_proportions = true,

				position = "float",
				popup = {
					size = {
						height = "80%",
						width = "50%",
					},
					position = "50%",
					title = function(state)
						return "Neo-tree " .. state.name:gsub("^%l", string.upper)
					end,
				},
			},
			filesystem = {
				-- bind_to_cwd = true,
				follow_current_file = {
				  enabled = true,
				  leave_dirs_open = true,
				},
				use_libuv_file_watcher = true,
				window = {
					mappings = {
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						-- ["/"] = {"fuzzy_finder", config = { keep_filter_on_submit = true }},
						-- ["/"] = "filter_as_you_type", -- this was the default until v1.28
						["D"] = "fuzzy_finder_directory",
						-- ["D"] = "fuzzy_sorter_directory",
						["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
						["f"] = "filter_on_submit",
						["<C-x>"] = "clear_filter",
						["-"] = "navigate_up",
						["."] = "set_root",
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
						["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
						["b"] = "rename_basename",
						["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["og"] = { "order_by_git_status", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
				},
				check_gitignore_in_search = false,
				filtered_items = {
					visible = true,
					hide_gitignored = false,
					hide_ignored = false,
					hide_hidden = false,
				},
				group_empty_dirs = false,
				search_limit = 50,
				hijack_netrw_behavior = "open_default",
			},
			buffers = {
				group_empty_dirs = false,
				window = {
					mappings = {
						["-"] = "navigate_up",
						["."] = "set_root",
						["d"] = "buffer_delete",
						["bd"] = "buffer_delete",
						["i"] = "show_file_details",
						--TO-DO: i will check rename
						["r"] = "rename_basename",
						["o"] = {
							"show_help",
							nowait = false,
							config = {
								title = "Order by", prefix_key = "o"
							}
						},
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
				},
			},
		})
	end
}
