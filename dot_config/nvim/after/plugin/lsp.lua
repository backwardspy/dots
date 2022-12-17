local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local null_ls = require("null-ls")
local navic = require("nvim-navic")
local lsp_format = require("lsp-format")

require("lspconfig.ui.windows").default_options.border = "rounded"

-- lsp package management
require("mason").setup({
    ui = {
        border = "rounded",
    },
})
mason_lspconfig.setup()

-- miscellaneous extra shiny
lsp_format.setup()
navic.setup({ highlight = true })

-- additional non-lsp tools to attach
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

-- config for all language servers
local default_config = {
    on_attach = function(client, bufnr)
        require("lsp-format").on_attach(client)

        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
        end

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

-- automatic setup
mason_lspconfig.setup_handlers({
    -- default handler
    function(server_name)
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
