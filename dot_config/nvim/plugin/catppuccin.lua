local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
    return
end

catppuccin.setup({
    transparent_background = true,
    term_colors = true,
    integrations = {
        fidget = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
        },
        mason = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
        navic = {
            enabled = true,
            custom_bg = "NONE",
        },
        neotree = true,
        cmp = true,
        telescope = true,
    },
})
vim.cmd.colorscheme("catppuccin")
