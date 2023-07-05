local lsp_venv = function()
  local env = PythonEnv()
  if env then
    return "(" .. env.venv_name .. ")"
  else
    return ""
  end
end

require("lualine").setup({
  options = {
    icons_enabled = false,
    fmt = string.lower,
    section_separators = { "   ", "   " },
    component_separators = { " ", " " },
    globalstatus = true,
  },
  sections = {
    lualine_a = { { "filename", symbols = { modified = "⬤" } } },
    lualine_b = { "branch", { "diff", colored = true } },
    lualine_c = { "searchcount", { "diagostics", sources = { "nvim_lsp" } } },
    lualine_x = { require("lsp-progress").progress, lsp_venv },
    lualine_y = { "filetype" },
    lualine_z = { "location", "mode" },
  },
})

-- refresh lualine on lsp progress update
vim.api.nvim_create_autocmd(
  "User",
  {
    pattern = "LspProgressStatusUpdated",
    group = vim.api.nvim_create_augroup("LualineLSPProgress", {}),
    callback = function() require("lualine").refresh() end,
  }
)

-- signs
-- full credit to LazyVim for this config
local signs = {
  dap = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
  },
  diagnostics = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  },
  git = {
    added = " ",
    modified = " ",
    removed = " ",
  },
}

vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
for name, sign in pairs(signs.dap) do
  sign = type(sign) == "table" and sign or { sign }
  vim.fn.sign_define(
    "Dap" .. name,
    {
      text = sign[1],
      texthl = sign[2] or "DiagnosticInfo",
      linehl = sign[3],
      numhl = sign[3],
    })
end

for name, sign in pairs(signs.diagnostics) do
  name = "DiagnosticSign" .. name
  vim.fn.sign_define(
    name,
    {
      text = sign,
      texthl = name,
      numhl = "",
    }
  )
end
