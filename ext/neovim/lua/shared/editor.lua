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
    },
    {
        "echasnovski/mini.ai",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                },
            }
        end,
        config = function(_, opts)
            require("mini.ai").setup(opts)
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = { enable = not vim.g.vscode },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>",
                        node_incremental = "<CR>",
                        node_decremental = "<C-CR>",
                    },
                },
            })
        end
    }
}
