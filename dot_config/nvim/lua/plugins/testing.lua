return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "antoinemadec/FixCursorHold.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-neotest/neotest-python",
            "nvim-treesitter/nvim-treesitter",
            "rouge8/neotest-rust",
        },
        keys = {
            {
                "<Leader>tt",
                function() require("neotest").run.run() end,
                desc = "Run nearest test"
            },
            {
                "<Leader>tf",
                function() require("neotest").run.run(vim.fn.expand("%")) end,
                desc = "Run all tests in the current file"
            },
            {
                "<Leader>tT",
                function() require("neotest").run.run(vim.fn.getcwd()) end,
                desc = "Run all tests in the current directory"
            },
            {
                "<Leader>td",
                function() require("neotest").run.run({ strategy = "dap" }) end,
                desc = "Debug nearest test"
            },
            {
                "<Leader>ts",
                function() require("neotest").run.stop() end,
                desc = "Stop nearest test"
            },
            {
                "<Leader>ta",
                function() require("neotest").run.attach() end,
                desc = "Attach to nearest test"
            },
            {
                "<Leader>tu",
                function()
                    require("neotest").output_panel.toggle()
                    require("neotest").summary.toggle()
                end,
                desc = "Toggle test output & summary panels"
            }
        },
        opts = function(_, opts)
            opts.adapters = {
                require("neotest-python")({
                    python = PythonEnv().pythonPath,
                }),
                require("neotest-rust"),
            }
        end,
    }
}
