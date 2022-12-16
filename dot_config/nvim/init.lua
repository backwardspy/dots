pcall(require, "impatient")

-- set this early so plugins etc can all use it
vim.g.mapleader = " "

require("plugins")
require("options")
require("binds")

-- highlight yank
vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = "highlight_yank",
    pattern = { "*" },
    callback = function()
        vim.highlight.on_yank({
            higroup = "Visual",
            timeout = 500,
        })
    end,
})
