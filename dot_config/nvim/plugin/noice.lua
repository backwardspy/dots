local ok, noice = pcall(require, "noice")
if not ok then
    return
end

local require_then = require("utils").require_then

require_then("notify", function(notify)
    notify.setup({
        background_colour = "#000000",
    })
end)

noice.setup({
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
