local lsp = require("lspconfig")

lsp.pyright.setup({})
lsp.ruff_lsp.setup({})
lsp.rust_analyzer.setup({})
lsp.lua_ls.setup({
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
        }
    }
})

vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "gh", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end)
vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end)

require("lspkind").init()
