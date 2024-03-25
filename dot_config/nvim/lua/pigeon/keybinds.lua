return {
    setup = function()
        vim.keymap.set("n", "gh", vim.diagnostic.open_float, { desc = "[LSP] Open Float" })

        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "Set LSP keybinds",
            group = require("pigeon.autocmds").group,
            callback = function(event)
                local function map(keys, fn, desc, modes, extra_opts)
                    local opts = { buffer = event.buf, desc = "[LSP] " .. desc }
                    if extra_opts then
                        vim.tbl_extend("force", opts, extra_opts)
                    end
                    modes = modes or { "n" }
                    vim.keymap.set(modes, keys, fn, opts)
                end
                map("K", vim.lsp.buf.hover, "Hover")
                map("gd", vim.lsp.buf.definition, "Go to Definition")
                map("gD", vim.lsp.buf.declaration, "Go to Declaration")
                map("gi", vim.lsp.buf.implementation, "Go to Implementation")
                map("go", vim.lsp.buf.type_definition, "Go to Type Definition")
                map("gr", vim.lsp.buf.references, "Go to References")
                map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
                map("<Leader>r", vim.lsp.buf.rename, "Rename")
                map("<Leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format Document")
                map("<Leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
            end,
        })
    end
}
