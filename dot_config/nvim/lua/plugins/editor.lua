return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "RRethy/nvim-treesitter-endwise",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "fish",
                    "html",
                    "javascript",
                    "jsdoc",
                    "json",
                    "luadoc",
                    "luap",
                    "markdown_inline",
                    "query",
                    "regex",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                    "lua",
                    "markdown",
                    "python",
                    "rust",
                },
                highlight = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>",
                        node_incremental = "<CR>",
                        node_decremental = "<BS>",
                    },
                },
                indent = {
                    enable = true,
                    disable = { "python", "yaml" },
                },
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                },
                endwise = { enable = true },
            })

            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
            vim.opt.foldenable = false

            require("treesitter-context").setup({
                max_lines = 3,
                min_window_height = 20,
                mode = "topline",
            })
        end
    },
    {
        "echasnovski/mini.nvim",
        version = false,
        lazy = false,
        config = function()
            require("mini.ai").setup()
            require("mini.basics").setup({ mappings = { windows = true } })
            require("mini.bracketed").setup()
            local miniclue = require("mini.clue")
            miniclue.setup({
                triggers = {
                    { mode = "n", keys = "<Leader>" },
                    { mode = "x", keys = "<Leader>" },
                    { mode = "i", keys = "<C-x>" },
                    { mode = "n", keys = "g" },
                    { mode = "x", keys = "g" },
                    { mode = "n", keys = "'" },
                    { mode = "x", keys = "'" },
                    { mode = "n", keys = "`" },
                    { mode = "x", keys = "`" },
                    { mode = "n", keys = '"' },
                    { mode = "x", keys = '"' },
                    { mode = "i", keys = "<C-r>" },
                    { mode = "c", keys = "<C-r>" },
                    { mode = "n", keys = "<C-w>" },
                    { mode = "n", keys = "z" },
                    { mode = "x", keys = "z" },
                    { mode = "n", keys = "[" },
                    { mode = "n", keys = "]" },
                },

                clues = {
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                    { mode = "n", keys = "<Leader>f", desc = "+Files" },
                    { mode = "n", keys = "<Leader>h", desc = "+Help" },
                    { mode = "n", keys = "<Leader>l", desc = "+LSP" },
                    { mode = "n", keys = "<Leader>t", desc = "+Test" },
                    { mode = "n", keys = "<Leader>x", desc = "+Debug" },
                },

                window = {
                    delay = 0,
                },
            })
            require("mini.comment").setup()
            require("mini.indentscope").setup({ symbol = "│" })
            require("mini.surround").setup({
                mappings = {
                    add = "ys",
                    delete = "ds",
                    find = "",
                    find_left = "",
                    highlight = "",
                    replace = "cs",
                    update_n_lines = "",
                }
            })
            require("mini.trailspace").setup()
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "utilyre/sentiment.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        opts = { suggestion = { auto_trigger = true } },
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            modes = { search = { enabled = false } }
        },
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function() require("flash").jump() end,
                desc = "Flash"
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function() require("flash").treesitter() end,
                desc = "Flash treesitter"
            },
            {
                "r",
                mode = "o",
                function() require("flash").remote() end,
                desc = "Remote flash"
            },
            {
                "R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc = "Flash treesitter search"
            },
            {
                "<C-s>",
                mode = { "c" },
                function() require("flash").toggle() end,
                desc = "Toggle flash search"
            },
        },
    },
    {
        "bennypowers/splitjoin.nvim",
        keys = {
            { "gj", function() require("splitjoin").join() end,  desc = "Join the object under cursor" },
            { "g,", function() require("splitjoin").split() end, desc = "Split the object under cursor" },
        },
    },
    {
        "ellisonleao/dotenv.nvim",
        event = "VeryLazy",
        opts = {
            enable_on_load = true,
        },
    }
}
