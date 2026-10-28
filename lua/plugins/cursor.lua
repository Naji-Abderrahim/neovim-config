return {
  "xTacobaco/cursor-agent.nvim",
  config = function()
    vim.keymap.set("n", "<leader>aa", ":CursorAgent<CR>", { desc = "Cursor Agent: Toggle terminal" })
    vim.keymap.set("v", "<leader>as", ":CursorAgentSelection<CR>", { desc = "Cursor Agent: Send selection" })
    vim.keymap.set("n", "<leader>ab", ":CursorAgentBuffer<CR>", { desc = "Cursor Agent: Send buffer" })
  end,
}
