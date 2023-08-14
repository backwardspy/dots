return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "dev-v3",
        dependencies = {
            "HallerPatrick/py_lsp.nvim",
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/nvim-cmp",
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim",
            "williamboman/mason.nvim",
        },
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lsp = require("lsp-zero").preset({})

            lsp.on_attach(function()
                lsp.default_keymaps({ preserve_mappings = false })

                local function map(lhs, rhs, opts)
                    opts = opts or {}
                    opts.buffer = true
                    vim.keymap.set("n", lhs, rhs, opts)
                end

                map("<Leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
                map("<Leader>lf", vim.lsp.buf.format, { desc = "Format document" })
                map("<Leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
                map("<Leader>ls", "<CMD>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
                map("<Leader>lS", "<CMD>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })
                map("<Leader>ld", "<CMD>Telescope diagnostics<CR>", { desc = "Diagnostics" })
                map("gd", "<CMD>Telescope lsp_definitions<CR>", { desc = "Definitions" })
                map("gi", "<CMD>Telescope lsp_implementations<CR>", { desc = "Implementations" })
                map("go", "<CMD>Telescope lsp_type_definitions<CR>", { desc = "Type definitions" })
                map("gr", "<CMD>Telescope lsp_references<CR>", { desc = "References" })
                map("gh", vim.diagnostic.open_float, { desc = "Show diagnostic" })
            end)

            lsp.extend_cmp()

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "ruff_lsp", "rust_analyzer", "lua_ls" },
                handlers = {
                    lsp.default_setup,
                    lua_ls = function()
                        require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
                    end,
                    pyright = function()
                        require("py_lsp").setup()
                    end,
                }
            })
        end
    },
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = { "black" },
                handlers = {},
            })
        end
    }
}
