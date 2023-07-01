local group = vim.api.nvim_create_augroup("Pigeon", {})
local autocmd = function(event, args)
  args.group = group
  vim.api.nvim_create_autocmd(event, args)
end

autocmd(
  "InsertEnter",
  {
    command = ":set norelativenumber",
    desc = "Disable relative numbers",
  }
)

autocmd(
  "InsertLeave",
  {
    command = ":set relativenumber",
    desc = "Enable relative numbers",
  }
)

autocmd(
  "InsertEnter",
  {
    callback = function()
      require("copilot").setup({ suggestion = { auto_trigger = true } })
    end,
    desc = "Lazy load Copilot",
  }
)

autocmd(
  "TextYankPost",
  {
    callback = function()
      vim.highlight.on_yank()
    end,
    desc = "Highlight on yank",
  }
)
