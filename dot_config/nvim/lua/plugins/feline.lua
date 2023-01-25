return {
    {
        "feline-nvim/feline.nvim",
        cond = not vim.g.vscode,
        config = function()
            local feline = require("feline")
            local ctp_feline = require("catppuccin.groups.integrations.feline")

            -- catppuccin statusline
            ctp_feline.setup({})
            feline.setup({ components = ctp_feline.get() })
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
}
