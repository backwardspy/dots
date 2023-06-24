require("catppuccin").setup({
    flavour = "mocha",
    show_end_of_buffer = true,
    term_colors = true,
    color_overrides = {
        mocha = {
            base = "#1D0D2D",
            crust = "#210F32",
            mantle = "#241138",
        }
    },
    integrations = {
        mini = true,
    },
})
vim.cmd.colorscheme("catppuccin")

