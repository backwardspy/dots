-- setting this in `keys` for lazy doesn't work, but this does.
vim.keymap.set("n", "<C-`>", "<cmd>ToggleTerm<cr>")
return {
    {
        "akinsho/toggleterm.nvim",
        config = function()
            local toggleterm = require("toggleterm")

            toggleterm.setup({
                size = 20,
            })

            local Terminal = require("toggleterm.terminal").Terminal
            local lazygit = Terminal:new({
                cmd = "lazygit",
                direction = "float",
                hidden = true,
            })
            vim.api.nvim_create_user_command("Git", function(opts)
                lazygit:toggle()
            end, {})
        end,
        cmd = { "Git", "ToggleTerm" },
    },
}
