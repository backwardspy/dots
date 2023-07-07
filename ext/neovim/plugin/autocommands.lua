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
  "TextYankPost",
  {
    callback = function()
      vim.highlight.on_yank()
    end,
    desc = "Highlight on yank",
  }
)

local lazy = function(spec)
  local name = spec[1]
  local plugin = spec.plugin or name
  local events = spec.events or { "BufReadPre", "BufNewFile" }
  local opts = spec.opts or {}
  local setup = spec.setup or function(o) require(name).setup(o) end
  autocmd(events, {
    desc = "Lazy load " .. name,
    once = true,
    callback = function()
      print("Lazyloading " .. name .. " (" .. plugin .. ")")
      vim.cmd.packadd(plugin)
      setup(opts)
    end,
  })
end

lazy({
  "copilot",
  plugin = "copilot.lua",
  events = "InsertEnter",
  opts = {
    suggestion = {
      auto_trigger = true,
    },
  }
})

lazy({ "gitsigns" })
