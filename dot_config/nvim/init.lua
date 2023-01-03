-- set this early so plugins etc can all use it
vim.g.mapleader = " "

-- bootstrap & set up lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", { install = { colorscheme = { "catppuccin" } } })

-- load remaining config
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
            timeout = 100,
        })
    end,
})
