return {
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
        },
    },
}
