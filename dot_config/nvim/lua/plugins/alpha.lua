return {
    {
        "goolord/alpha-nvim",
        cond = not vim.g.vscode,
        config = function()
            local alpha = require("alpha")
            require("alpha.term")
            local db = require("alpha.themes.dashboard")

            db.section.terminal.command = "cat | " .. vim.fn.stdpath("data") .. "/boog.ccat"
            db.section.terminal.width = 24
            db.section.terminal.height = 12
            db.section.terminal.opts.redraw = true

            db.section.header.val = "boogievim"

            db.section.buttons.val = {
                db.button("SPC f f", "Find Files", ":Telescope find_files<cr>"),
                db.button("SPC f r", "Recent Files", ":Telescope oldfiles<cr>"),
                db.button("SPC f s", "Live Grep", ":Telescope live_grep<cr>"),
            }

            db.config.layout = {
                { type = "padding", val = 1 },
                db.section.terminal,
                { type = "padding", val = 14 },
                db.section.header,
                { type = "padding", val = 1 },
                db.section.buttons,
                { type = "padding", val = 1 },
                db.section.footer,
            }

            alpha.setup(db.opts)
        end
    },
}
