return {
    {
        "backwardspy/pigeon.nvim",
        dependencies = { "rktjmp/lush.nvim" },
    },
    {
        "olivercederborg/poimandres.nvim",
        opts = {},
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {},
    },
    {
        "nyngwang/nvimgelion",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.background = "dark"
            vim.cmd.colorscheme("nvimgelion")

            local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
            hl.bg = nil
            vim.api.nvim_set_hl(0, "Normal", hl)
        end
    },
    "nyoom-engineering/oxocarbon.nvim",
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            { "linrongbin16/lsp-progress.nvim", opts = {} },
            "KadoBOT/nvim-spotify",
        },
        opts = {
            options = {
                icons_enabled = false,
                theme = "auto",
                component_separators = { left = " ", right = " " },
                section_separators = { left = "", right = "" },
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "filename" },
                lualine_c = { "require('lsp-progress').progress()" },
                lualine_x = {},
                lualine_y = {},
                lualine_z = { "require('nvim-spotify').status.listen()" },
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {},
    },
}
