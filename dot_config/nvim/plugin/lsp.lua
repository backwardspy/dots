local ok, mason = pcall(require, "mason")
if not ok then return end

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local null_ls = require("null-ls")
local navic = require("nvim-navic")

require('lspconfig.ui.windows').default_options.border = "rounded"
mason.setup({
    ui = {
        border = "rounded"
    }
})
mason_lspconfig.setup()

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
        require("lsp_signature").on_attach({}, bufnr)

        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
        end
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
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' },
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

require("fidget").setup()
