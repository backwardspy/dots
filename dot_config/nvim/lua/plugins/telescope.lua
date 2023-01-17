return {
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("telescope").load_extension("catppuccin")
        end,
        keys = {
            { "<leader>fc", "<cmd>Telescope catppuccin<cr>", "Catppuccin Colours" },
            { "<leader>fd", "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
            { "<leader>ff", "<cmd>Telescope find_files<cr>", "Find files" },
            { "<leader>fg", "<cmd>Telescope git_files<cr>", "Git files" },
            { "<leader>fj", "<cmd>Telescope jumplist<cr>", "Jumplist" },
            { "<leader>fs", "<cmd>Telescope live_grep<cr>", "Live grep" },
        },
        cmd = "Telescope",
        dependencies = {
            "backwardspy/telescope-catppuccin.nvim",
        }
    },
}
