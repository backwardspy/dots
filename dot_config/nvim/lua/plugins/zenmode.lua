local extremely_zen = function()
    require("zen-mode").toggle({ plugins = { twilight = { enabled = true } } })
end

return {
    {
        "folke/zen-mode.nvim",
        config = {
            window = {
                options = {
                    statuscolumn = "",
                },
            },
            plugins = {
                twilight = { enabled = false },
            },
        },
        cmd = { "ZenMode" },
        keys = {
            { "<leader><leader>", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
            { "<leader>,", extremely_zen, desc = "Extremely Zen Mode" },
        },
        dependencies = { "folke/twilight.nvim" },
    },
}
