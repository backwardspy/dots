return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    -- these are just bare minimum for my workflow & plugins.
                    -- i'd recommend running `:TSInstall all` on a decent connection.
                    "python",
                    "rust",
                    "go",
                    "lua",
                },
                highlight = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<cr>",
                        scope_incremental = "<cr>",
                        node_incremental = "<tab>",
                        node_decremental = "<s-tab>",
                    },
                },
                indent = { enable = false },
            })
        end,
    },
}
