local get_venvs_path = function()
  if vim.fn.executable("poetry") == 1 then
    local venvs_path = vim.fn.system("poetry config virtualenvs.path")
    -- remove trailing newline
    venvs_path = string.sub(venvs_path, 1, -2)
    return venvs_path
  else
    return vim.fn.getcwd()
  end
end

require("swenv").setup({
  venvs_path = get_venvs_path(),
  post_set_venv = function() vim.cmd.LspRestart() end,
})

require("which-key").register({
  ["<leader>lv"] = {
    function() require("swenv.api").pick_venv() end,
    "Pick venv",
  }
})
