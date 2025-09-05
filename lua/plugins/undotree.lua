return {
  "mbbill/undotree",
  -- You can add options here if the plugin supports them
  opts = {},
  -- The config function runs after the plugin is loaded
  config = function()
    -- Create a keymap to toggle the undotree window
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle UndoTree" })
  end,
}
