return {
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require('telescope').load_extension('fzy_native')
            require("telescope").load_extension("catppuccin")
            require("telescope").load_extension("smart_open")
        end,
        keys = {
            { "<leader>fc", "<cmd>Telescope catppuccin<cr>", "Catppuccin Colours" },
            { "<leader>fd", "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
            { "<leader>ff", "<cmd>Telescope smart_open<cr>", "Find files" },
            { "<leader>fj", "<cmd>Telescope jumplist<cr>", "Jumplist" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", "Recent Files" },
            { "<leader>fs", "<cmd>Telescope live_grep<cr>", "Live grep" },
        },
        cmd = "Telescope",
        dependencies = {
            {
                "nvim-telescope/telescope-fzy-native.nvim",
                dependencies = { "kkharji/sqlite.lua" },
            },
            "danielfalk/smart-open.nvim",
            "backwardspy/telescope-catppuccin.nvim",
        }
    },
}
