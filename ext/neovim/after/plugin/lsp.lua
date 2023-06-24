local lsp = require("lspconfig")

local setup = function(server, opts)
    opts = opts or {}
    -- opts.on_attach = function(client, bufnr) end
    server.setup(opts)
end

setup(lsp.pyright)
setup(lsp.ruff_lsp)
setup(lsp.rust_analyzer)
setup(lsp.lua_ls, {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
        }
    }
})

-- lsp symbol icons
require("lspkind").init()

-- multiline diagnostics
require("lsp_lines").setup()
vim.diagnostic.config({virtual_text = false})
