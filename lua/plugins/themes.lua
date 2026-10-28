return {
	-- {"Mofiqul/dracula.nvim",
  "catppuccin/nvim",
  -- "folke/tokyonight.nvim"},
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "catppuccin-macchiato"
  end,
}
