return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        enabled = not vim.g.vscode,
        config = function(opts)
            local flavour = os.getenv("appearance") == "light" and "latte" or "mocha"
            require("catppuccin").setup({
                flavour = flavour,
                transparent_background = true,
                show_end_of_buffer = true,
                term_colors = true,
            })
            vim.cmd.colorscheme("catppuccin")
        end
    }
}
