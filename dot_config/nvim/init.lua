local pigeon = require("pigeon")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.background = "light"

vim.keymap.set("n", "<C-s>", "<cmd>write<cr>")

local sitepath = pigeon.deps.bootstrap()
require("mini.deps").setup({ path = { package = sitepath } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
    require("mini.basics").setup()
end)

later(function()
    add({
        source = "nvim-treesitter/nvim-treesitter",
        hooks = { post_checkout = function() vim.cmd.TSUpdate() end },
    })
    add({ source = "nushell/tree-sitter-nu", })
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "lua",
            "vimdoc",
            "python",
            "rust",
            "nu",
        },
        highlight = { enable = true },
    })
end)
