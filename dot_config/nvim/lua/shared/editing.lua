return {
    {
        "echasnovski/mini.surround",
        lazy = not vim.g.vscode,
        keys = { "sa", "sd", "sr", "sf", "sF", "sh" },
        config = function(_, opts)
            require("mini.surround").setup(opts)
        end
    }
}
