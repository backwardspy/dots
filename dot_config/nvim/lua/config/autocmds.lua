local group = vim.api.nvim_create_augroup("pigeon", { clear = true })
local function autocmd(event, pattern, command)
  local opts = {
    group = group,
    pattern = pattern,
  }

  if type(command) == "function" then
    opts.callback = command
  else
    opts.command = command
  end

  vim.api.nvim_create_autocmd(event, opts)
end

autocmd("InsertEnter", "*", "set nornu")
autocmd("InsertLeave", "*", "set rnu")
