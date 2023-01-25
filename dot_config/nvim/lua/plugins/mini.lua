return {
    {
        "echasnovski/mini.nvim",
        config = function()
            -- add gc/gcc actions, gc textobject
            require("mini.comment").setup({})
            
            if vim.g.vscode then
                return
            end

            -- highlight word under cursor
            require("mini.cursorword").setup({ delay = 0 })

            -- indent lines, `i` textobject, `]i`/`[i` motions
            require("mini.indentscope").setup({
                draw = { delay = 0 },
                symbol = "│",
            })
            vim.api.nvim_create_autocmd({ "TermOpen" }, {
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
            vim.api.nvim_create_autocmd({ "FileType" }, {
                pattern = { "help", "alpha", "mason", "lazy" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
}
