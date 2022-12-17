require("executor").setup({})
vim.keymap.set("n", "<leader>er", vim.cmd.ExecutorRun)
vim.keymap.set("n", "<leader>ec", vim.cmd.ExecutorSetCommand)
vim.keymap.set("n", "<leader>ev", vim.cmd.ExecutorToggle)
