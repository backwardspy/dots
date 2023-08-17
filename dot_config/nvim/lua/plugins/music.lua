return {
    -- TODO: this plugin needs updating due to telescope changes
    -- statusline works fine, but we can't search for content
    {
        "KadoBOT/nvim-spotify",
        cond = vim.fn.executable("spt") ~= 0 and vim.fn.executable("go") ~= 0,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            { "akinsho/toggleterm.nvim", opts = {} },
        },
        build = "make",
        event = "VeryLazy",
        opts = {},
        config = function(plugin, opts)
            local spotify = require(plugin.name)
            spotify.setup(opts)
            spotify.status:start()

            local Terminal = require("toggleterm.terminal").Terminal
            local spt = Terminal:new({
                cmd = "spt",
                hidden = true,
                direction = "float",
            })
            function SptToggle()
                spt:toggle()
            end

            vim.api.nvim_set_keymap(
                "n",
                "<leader>m",
                "<CMD>lua SptToggle()<CR>",
                { desc = "Spotify" }
            )
        end
    }
}
