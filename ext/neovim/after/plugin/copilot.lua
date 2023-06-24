vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    group = vim.api.nvim_create_augroup("CopilotLazy", {}),
    callback = function()
        require("copilot").setup({ suggestion = { auto_trigger = true } })
    end,
})
