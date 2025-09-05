return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
	  require("toggleterm").setup({
		  open_mapping = [[<c-p>]],
		  hide_numbers = false,
		  start_in_insert = true,
		  close_on_exit = true,
		  shell = "/usr/bin/bash"
	  })
  end,
}
