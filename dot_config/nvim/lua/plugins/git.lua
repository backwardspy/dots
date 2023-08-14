return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "sindrets/diffview.nvim",
        },
        cmd = "Neogit",
        keys = {
            { "<Leader>g", "<cmd>Neogit<cr>", desc = "Neogit" }
        },
        opts = {},
    }
}
