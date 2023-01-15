local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({ float = { border = "rounded" } })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local default_config = {
    on_attach = function(client, bufnr)
        require("lsp-format").on_attach(client)
        require("lsp_signature").on_attach({}, bufnr)

        if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
        end

        -- add lsp-only keybinds
        local map = function(sequence, cmd, desc)
            vim.keymap.set("n", sequence, cmd, { buffer = bufnr, desc = desc })
        end

        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("K", vim.lsp.buf.hover, "Hover")
        map("]d", vim.diagnostic.goto_next, "Next diagnostic")
        map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")

        map("<leader>la", vim.lsp.buf.code_action, "Code Action")
        map("<leader>lr", vim.lsp.buf.rename, "Rename")
        map("<leader>lf", vim.lsp.buf.format, "Format")
        map("<leader>so", function()
            require("telescope.builtin").lsp_document_symbols()
        end, "Document symbols")
        map("<leader>sp", function()
            require("telescope.builtin").lsp_workspace_symbols()
        end, "Workspace symbols")
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
                            -- https://github.com/simrat39/rust-tools.nvim/issues/300
                            local config = custom_config({
                                settings = {
                                    ["rust-analyzer"] = {
                                        inlayHints = { locationLinks = false },
                                    },
                                },
                            })
                            require("rust-tools").setup({
                                server = config,
                                dap = {
                                    adapter = {
                                        type = "server",
                                        port = "${port}",
                                        host = "127.0.0.1",
                                        executable = {
                                            command = "codelldb",
                                            args = { "--port", "${port}" },
                                        },
                                    },
                                },
                            })
                        end,

                        ["pyright"] = function()
                            require("py_lsp").setup(default_config)
                        end,

                        ["sumneko_lua"] = function()
                            require("lspconfig")["sumneko_lua"].setup(custom_config({
                                settings = {
                                    Lua = {
                                        format = {
                                            enable = false,
                                        },
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
                    "williamboman/mason.nvim",
                    { "folke/neodev.nvim", config = true },
                },
            },
            "simrat39/rust-tools.nvim",
            "HallerPatrick/py_lsp.nvim",
            { "SmiteshP/nvim-navic", config = { highlight = true } },
            "onsails/lspkind.nvim",
            { "lukas-reineke/lsp-format.nvim", config = true },
            "folke/neodev.nvim",
            "ray-x/lsp_signature.nvim",
            "glepnir/lspsaga.nvim",
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
