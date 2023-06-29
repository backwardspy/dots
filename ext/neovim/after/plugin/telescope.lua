local ts = require("telescope")

ts.setup({
    defaults = vim.tbl_extend("force", require("telescope.themes").get_ivy(), {
        path_display = { shorten = { len = 3, exclude = { 1, -1 } } },
        border = false,
    }),
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_cursor(),
        },
    },
})

ts.load_extension("fzf") -- native sorter
ts.load_extension("ui-select") -- use telescope for code actions etc
ts.load_extension("undo") -- undo tree
