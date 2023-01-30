return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        enabled = not vim.g.vscode,
        config = function(opts)
            require("catppuccin").setup({
                transparent_background = true,
                show_end_of_buffer = true,
                term_colors = true,
            })
            vim.cmd.colorscheme("catppuccin")
        end
    }
}
