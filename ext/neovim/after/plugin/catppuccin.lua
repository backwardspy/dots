require("catppuccin").setup({
    flavour = "mocha",
    color_overrides = {
        mocha = {
            base = "#1D0D2D",
            crust = "#210F32",
            mantle = "#241138",
        }
    }
})
vim.cmd.colorscheme("catppuccin")
