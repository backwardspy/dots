vim.g.mapleader = " "

-- bootstrap lazy.nvim
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

-- setup plugins
require("lazy").setup("plugins", {
    install = {
        missing = not vim.g.vscode,
        colorscheme = { "catppuccin" },
    },
    ui = {
        border = "rounded",
    },
    change_detection = {
        notify = false,
    }
})

require("options")
require("keybinds")
require("autocmds")

