return {
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", "Find files" },
            { "<leader>fg", "<cmd>Telescope git_files<cr>", "Git files" },
            { "<leader>fs", "<cmd>Telescope live_grep<cr>", "Live grep" },
        },
        cmd = "Telescope",
    },
}
