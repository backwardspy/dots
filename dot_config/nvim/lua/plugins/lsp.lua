return {
    "VonHeikemen/lsp-zero.nvim",
    config = function()
        local lsp = require("lsp-zero")
        lsp.preset("recommended")
        lsp.ensure_installed({ "sumneko_lua", "pyright", "rust_analyzer" })
        lsp.skip_server_setup({ "rust_analyzer", "pyright" })

        lsp.configure("sumneko_lua", {
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
        })

        lsp.on_attach(function(client, bufnr)
            require("lsp-format").on_attach(client)
            require("lsp_signature").on_attach({}, bufnr)

            if client.server_capabilities.documentSymbolProvider then
                require("nvim-navic").attach(client, bufnr)
            end
        end)

        lsp.setup_nvim_cmp({
            formatting = {
                format = require("lspkind").cmp_format({
                    mode = "symbol", -- show only symbol annotations
                    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

                    -- The function below will be called before any actual modifications from lspkind
                    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                    before = function(entry, vim_item)
                        return vim_item
                    end,
                }),
            },
        })

        lsp.setup()

        local rs_config = lsp.build_options("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    -- https://github.com/simrat39/rust-tools.nvim/issues/300
                    inlayHints = { locationLinks = false },
                },
            },
        })

        require("rust-tools").setup({
            server = rs_config,
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

        local py_config = lsp.build_options("pyright", {})
        require("py_lsp").setup(py_config)
    end,
    dependencies = {
        -- lsp
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        {
            "jay-babu/mason-null-ls.nvim",
            config = {
                ensure_installed = { "stylua", "black", "isort" },
            },
            dependencies = {
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
            },
        },
        "simrat39/rust-tools.nvim",
        "HallerPatrick/py_lsp.nvim",
        { "SmiteshP/nvim-navic", config = { highlight = true } },
        { "lukas-reineke/lsp-format.nvim", config = true },
        "folke/neodev.nvim",
        "ray-x/lsp_signature.nvim",
        { "folke/neodev.nvim", config = true },

        -- completion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim",
    },
}
