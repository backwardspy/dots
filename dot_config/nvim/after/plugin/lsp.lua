local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local null_ls = require("null-ls")
local navic = require("nvim-navic")

require("lspconfig.ui.windows").default_options.border = "rounded"

require("mason").setup({
    ui = {
        border = "rounded",
    },
})
mason_lspconfig.setup()

navic.setup({ highlight = true })

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

local default_config = {
    on_attach = function(client, bufnr)
        -- require("lsp_signature").on_attach({}, bufnr)

        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
        end

        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>fs", require("telescope.builtin").lsp_workspace_symbols, opts)
    end,
}

local custom_config = function(config)
    local merged_config = vim.deepcopy(default_config)
    merged_config = vim.tbl_extend("force", merged_config, config)
    return merged_config
end

-- automatic setup
mason_lspconfig.setup_handlers({
    function(server_name) -- default handler
        lspconfig[server_name].setup(default_config)
    end,

    -- specific handlers
    ["rust_analyzer"] = function()
        require("rust-tools").setup({})
    end,

    ["pyright"] = function()
        require("py_lsp").setup({})
    end,

    ["sumneko_lua"] = function()
        lspconfig["sumneko_lua"].setup(custom_config({
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
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
