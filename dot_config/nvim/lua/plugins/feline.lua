return {
    {
        "feline-nvim/feline.nvim",
        config = function()
            local navic = require("nvim-navic")
            local feline = require("feline")
            local ctp_feline = require("catppuccin.groups.integrations.feline")

            -- catppuccin statusline
            ctp_feline.setup({})
            feline.setup({ components = ctp_feline.get() })

            -- navic winbar
            feline.winbar.setup({
                components = {
                    active = {
                        {
                            {
                                provider = function()
                                    return navic.get_location()
                                end,
                                enabled = function()
                                    return navic.is_available()
                                end,
                            },
                        },
                    },
                    inactive = {},
                },
            })
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
}
