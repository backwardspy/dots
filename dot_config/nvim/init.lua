-- warn if we don't have all the tools we need
(function()
    local required_tools = {
        "git",
        "make",
        "node",
        "npm",
        "python",
        "rg",
        "unzip",
    }
    for _, tool in ipairs(required_tools) do
        if vim.fn.executable(tool) == 0 then
            vim.api.nvim_err_writeln("missing required tool: " .. tool)
        end
    end
end)()

require("pigeon.options")
require("pigeon.keybinds")
require("pigeon.utils")

if vim.fn.has("wsl") ~= 0 then
    require("pigeon.wsl")
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    defaults = {
        lazy = true
    },
    dev = {
        path = "~/src/backwardspy",
        patterns = { "backwardspy" },
        fallback = true,
    },
    install = {
        colorscheme = { "oxocarbon" },
    },
    checker = {
        notify = false,
    },
    change_detection = {
        notify = false,
    },
    performance = {
        disabled_plugins = {
            "gzip",
            "matchparen",
            "netrw",
            "netrwPlugin",
            "tar",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zip",
            "zipPlugin",
        },
    },
})
