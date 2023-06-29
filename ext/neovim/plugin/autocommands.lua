local auto_rnu = vim.api.nvim_create_augroup("AutoRelativeNumber", {})
vim.api.nvim_create_autocmd(
  "InsertEnter",
  {
    group = auto_rnu,
    command = ":set norelativenumber",
    desc = "Disable relative numbers",
  }
)
vim.api.nvim_create_autocmd(
  "InsertLeave",
  {
    group = auto_rnu,
    command = ":set relativenumber",
    desc = "Enable relative numbers",
  }
)

vim.api.nvim_create_autocmd(
  "InsertEnter",
  {
    group = vim.api.nvim_create_augroup("CopilotLazy", {}),
    callback = function()
      require("copilot").setup({ suggestion = { auto_trigger = true } })
    end,
    desc = "Lazy load Copilot",
  }
)
