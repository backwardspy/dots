return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "jay-babu/mason-nvim-dap.nvim",
            "mfussenegger/nvim-dap-python",
            -- we need mason, so we wait for lsp-zero to be set up
            "VonHeikemen/lsp-zero.nvim"
        },
        keys = {
            { "<Leader>xb",  function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
            { "<Leader>xr",  function() require("dap").repl.open() end,         desc = "Open REPL" },
            { "<Leader>xsi", function() require("dap").step_into() end,         desc = "Step into" },
            { "<Leader>xso", function() require("dap").step_over() end,         desc = "Step over" },
            { "<Leader>xx",  function() require("dap").continue() end,          desc = "Start/Continue" },
        },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { "python", "codelldb" },
                handlers = {
                    function(config) require("mason-nvim-dap").default_setup(config) end,

                    -- for rust we can get the executable from cargo automatically
                    codelldb = function(config)
                        config.configurations[1].program = function()
                            local output = vim.fn.systemlist("cargo build -q --message-format=json 2>1")
                            for _, l in ipairs(output) do
                                local json = vim.json.decode(l)
                                if json == nil then
                                    error("error parsing json")
                                end
                                if json.success == false then
                                    return error("error building package")
                                end
                                if json.executable ~= nil then
                                    return json.executable
                                end
                            end
                        end
                        require("mason-nvim-dap").default_setup(config)
                    end
                },
            })

            local dap_py = require("dap-python")
            dap_py.resolve_python = function()
                local env = PythonEnv()
                if env then
                    return env.pythonPath
                else
                    return "python3"
                end
            end
            dap_py.setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

            local dap, dapui = require("dap"), require("dapui")

            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            require("nvim-dap-virtual-text").setup()
        end,
    },
}
