return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "lua" },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter" },
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = { "prettier" },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "neovim/nvim-lspconfig", "mason.nvim" },
        opts = {
            ensure_installed = { "lua_ls", "ruff_lsp", "basedpyright", "rust_analyzer", "yamlls" },
            automatic_installation = true,
            handlers = {
                function(server)
                    require("lspconfig")[server].setup({})
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({})
                end
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                javascript = { "prettier" },
                markdown = { "prettier" },
                typescript = { "prettier" },
                yaml = { "prettier" },
            }
        },
    },
    {
        "zapling/mason-conform.nvim",
        dependencies = { "mason.nvim", "conform.nvim" },
        opts = {},
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = vim.fn.executable("make") == 1 and "make"
                    or
                    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
                enabled = vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1,
            },
            "nvim-telescope/telescope-ui-select.nvim",
        },
        keys = {
            { "<Leader>f", "<CMD>Telescope find_files<CR>", desc = "Find Files" },
            { "<Leader>s", "<CMD>Telescope live_grep<CR>",  desc = "Search" },
        },
        cmd = { "Telescope" },
        event = { "LspAttach" }, -- so we can use ui-select for code actions
        config = function()
            local telescope = require("telescope")
            telescope.load_extension("ui-select")
            telescope.load_extension("fzf")
        end,
    },
    {
        "echasnovski/mini.nvim",
        config = function()
            require("mini.ai").setup()
            require("mini.align").setup()
            require("mini.basics").setup({
                options = {
                    extra_ui = true,
                },
                mappings = {
                    windows = true,
                },
            })
            require("mini.bracketed").setup()
            local miniclue = require('mini.clue')
            miniclue.setup({
                window = {
                    delay = 200,
                },
                triggers = {
                    -- Leader triggers
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },

                    -- Built-in completion
                    { mode = 'i', keys = '<C-x>' },

                    -- `g` key
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },

                    -- Marks
                    { mode = 'n', keys = "'" },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = "'" },
                    { mode = 'x', keys = '`' },

                    -- Registers
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },

                    -- Window commands
                    { mode = 'n', keys = '<C-w>' },

                    -- `z` key
                    { mode = 'n', keys = 'z' },
                    { mode = 'x', keys = 'z' },

                    -- mini.basics
                    { mode = "n", keys = [[\]] },
                    { mode = "x", keys = [[\]] },

                    -- mini.bracketed
                    { mode = "n", keys = "[" },
                    { mode = "n", keys = "]" },
                    { mode = "x", keys = "[" },
                    { mode = "x", keys = "]" },

                    -- mini.surround
                    { mode = "n", keys = "s" },
                    { mode = "x", keys = "s" },
                },
                clues = {
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                },
            })
            require("mini.comment").setup()
            require("mini.completion").setup()
            require("mini.cursorword").setup()
            require("mini.files").setup()
            vim.keymap.set("n", "<Leader>F", MiniFiles.open, { desc = "Mini Files" })
            require("mini.indentscope").setup({ symbol = "│" })
            require("mini.jump").setup()
            require("mini.pairs").setup()
            require("mini.splitjoin").setup()
            require("mini.surround").setup()
            require("mini.trailspace").setup()
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {},
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        opts = {
            flavour = "auto",
            term_colors = true,
            integrations = {
                mason = true,
                mini = {
                    enabled = true,
                    indentscope_color = "rosewater",
                },
                telescope = {
                    style = "nvchad",
                },
            }
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end
    },
}
