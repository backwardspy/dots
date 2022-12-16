require("notify").setup({
    background_colour = "#000000",
})

require("noice").setup({
    lsp = {
        -- override markdown rendering so that cmp and other plugins use treesitter
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
        progress = { enabled = false },
    },
    presets = {
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
    },
})
