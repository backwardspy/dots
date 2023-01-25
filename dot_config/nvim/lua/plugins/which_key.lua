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
                g = { name = "Go to" },
                ["]"] = { name = "Next" },
                ["["] = { name = "Previous" },
            })

            wk.register({
                f = { name = "Find" },
                g = { name = "Git" },
                j = { name = "Jump" },
                l = { name = "LSP"},
                o = { name = "Open" },
                s = { name = "Search" },
                t = { name = "Tasks" },
                x = { name = "Debug" },
            }, { prefix = "<leader>" })
            
            if vim.g.vscode then
                local act = function(name)
                    return '<cmd>call VSCodeNotify("'..name..'")<cr>'
                end

                wk.register({
                    f = {
                        f = { act("workbench.action.quickOpen"), "Quick Open" },
                        s = { act("workbench.action.findInFiles"), "Find in Files" },
                    },
                    l = {
                        d = { act("workbench.action.gotoSymbol"), "Go to Symbol" },
                        r = { act("editor.action.refactor"), "Refactor" },
                        R = { act("editor.action.changeAll"), "Change All Occurrences" },
                    },
                }, { prefix = "<leader>" })
            end
        end,
    },
}
