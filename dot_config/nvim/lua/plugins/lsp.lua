local default_config = {
    on_attach = function(client, bufnr)
        require("lsp-format").on_attach(client)

        if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
        end

        require("lsp_signature").on_attach({}, bufnr)

        -- add lsp-only keybinds
        local wk = require("which-key")
        wk.register({
            g = {
                name = "Go to",
                d = { vim.lsp.buf.definition, "Definition" },
            },
            K = { vim.lsp.buf.hover, "Hover" },
            d = {
                name = "Diagnostic",
                n = { vim.diagnostic.goto_next, "Next" },
                N = { vim.diagnostic.goto_prev, "Previous" },
            },
        })

        wk.register({
            c = {
                name = "Code",
                a = { vim.lsp.buf.code_action, "Action" },
                r = { vim.lsp.buf.rename, "Rename" },
                f = { vim.lsp.buf.format, "Format" },
            },
            f = {
                name = "Find",
                o = {
                    function()
                        require("telescope.builtin").lsp_document_symbols()
                    end,
                    "Document symbols",
                },
                p = {
                    function()
                        require("telescope.builtin").lsp_workspace_symbols()
                    end,
                    "Workspace symbols",
                },
            },
        }, { buffer = bufnr, prefix = "<leader>" })
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
                            require("rust-tools").setup({ server = default_config })
                        end,

                        ["pyright"] = function()
                            require("py_lsp").setup(default_config)
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
