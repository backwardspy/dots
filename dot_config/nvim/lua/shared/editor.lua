return {
    {
        "echasnovski/mini.basics",
        config = function(_, opts)
            require("mini.basics").setup(opts)
        end,
    },
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end,
    },
    {
        "echasnovski/mini.surround",
        lazy = not vim.g.vscode,
        keys = { "sa", "sd", "sr", "sf", "sF", "sh" },
        config = function(_, opts)
            require("mini.surround").setup(opts)
        end
    },
    {
        "echasnovski/mini.comment",
        lazy = not vim.g.vscode,
        keys = { "gc" },
        config = function(_, opts)
            require("mini.comment").setup(opts)
        end,
    }
}
