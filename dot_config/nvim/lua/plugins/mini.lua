return {
    {
        "echasnovski/mini.nvim",
        config = function()
            -- add gc/gcc actions, gc textobject
            require("mini.comment").setup({})

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
        end,
    },
}
