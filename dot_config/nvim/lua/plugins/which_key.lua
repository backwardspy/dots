return {
    {
        "folke/which-key.nvim",
        config = function()
            local wk = require("which-key")
            wk.setup({
                window = {
                    border = "single",
                }
            })

            wk.register({
                g = { desc = "Go to" },
                ["]"] = { desc = "Next" },
                ["["] = { desc = "Previous" },
            })

            wk.register({
                c = { desc = "+Code" },
                g = { desc = "+Git" },
                j = { desc = "+Jump" },
                o = { desc = "+Open" },
                f = { desc = "+Files" },
                s = { desc = "+Search" },
                t = { desc = "+Tasks" },
                x = { desc = "+Debug" },
            }, { prefix = "<leader>" })
        end,
    },
}
