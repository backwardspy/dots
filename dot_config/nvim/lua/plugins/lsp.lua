local default_config = {
    on_attach = function(client, bufnr)
        require("lsp-format").on_attach(client)

        if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
        end

        require("lsp_signature").on_attach({}, bufnr)

        -- add lsp-only keybinds
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, opts)
        vim.keymap.set("n", "<leader>fs", require("telescope.builtin").lsp_workspace_symbols, opts)
    end,
}

local custom_config = function(config)
    local merged_config = vim.deepcopy(default_config)
    merged_config = vim.tbl_extend("force", merged_config, config)
    return merged_config
end

return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lspconfig.ui.windows").default_options.border = "rounded"
        end,
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                    require("mason-lspconfig").setup({
                        ensure_installed = { "rust_analyzer", "pyright", "sumneko_lua" },
                    })
                    require("mason-lspconfig").setup_handlers({
                        -- default handler
                        function(server_name)
                            require("lspconfig")[server_name].setup(default_config)
                        end,

                        -- specific handlers
                        ["rust_analyzer"] = function()
                            require("rust-tools").setup({})
                        end,

                        ["pyright"] = function()
                            require("py_lsp").setup({})
                        end,

                        ["sumneko_lua"] = function()
                            require("lspconfig")["sumneko_lua"].setup(custom_config({
                                settings = {
                                    Lua = {
                                        workspace = {
                                            checkThirdParty = false,
                                        },
                                        telemetry = {
                                            enable = false,
                                        },
                                    },
                                },
                            }))
                        end,
                    })
                end,
                dependencies = {
                    {
                        "williamboman/mason.nvim",
                        config = { ui = { border = "rounded" } },
                    },
                    { "folke/neodev.nvim", config = true },
                },
            },
            "simrat39/rust-tools.nvim",
            "HallerPatrick/py_lsp.nvim",
            "ray-x/lsp_signature.nvim",
            { "SmiteshP/nvim-navic", config = { highlight = true } },
            "onsails/lspkind.nvim",
            { "lukas-reineke/lsp-format.nvim", config = true },
            "folke/neodev.nvim",
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua.with({
                        extra_args = { "--indent-type", "spaces" },
                    }),
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort.with({
                        extra_args = { "--profile", "black" },
                    }),
                },
            })
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "jay-babu/mason-null-ls.nvim",
        config = {
            ensure_installed = { "stylua", "black", "isort" },
        },
    },
}
