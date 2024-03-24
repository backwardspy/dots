vim.opt.background = "light"
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

require("pigeon").setup()

-- keep this before lazy setup so plugins use the right keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","
require("lazy").setup("plugins", {
    install = {
        colorscheme = { "default" },
    },
    change_detection = {
        notify = false,
    },
    performance = {
        disabled_plugins = {
            "gzip",
            "matchit",
            "matchparen",
            "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
        }
    }
})
