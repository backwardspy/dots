if vim.g.vscode then
  require("config.vscode")
else
  require("config.lazy")
end
