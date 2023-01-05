local get_python_path = function()
    for _, client in pairs(vim.lsp.buf_get_clients()) do
        if client.name == "pyright" then
            local path = client.config.settings.python.pythonPath
            if path ~= nil then
                return path
            else
                return "python"
            end
        end
    end
end

return {
    {
        "rcarriga/nvim-dap-ui",
        config = true,
        dependencies = { "mfussenegger/nvim-dap" },
    },
    {
        "jayp0521/mason-nvim-dap.nvim",
        config = function()
            local dap = require("dap")
            local mason_dap = require("mason-nvim-dap")

            mason_dap.setup({
                ensure_installed = { "python", "codelldb" },
                automatic_setup = true,
            })
            mason_dap.setup_handlers({
                -- default handler
                function(source)
                    require("mason-nvim-dap.automatic_setup")(source)
                end,

                -- custom handlers
                python = function(_)
                    dap.adapters.python = {
                        type = "executable",
                        command = "debugpy-adapter",
                    }

                    dap.configurations.python = {
                        {
                            name = "Launch current file",
                            type = "python",
                            request = "launch",
                            program = "${file}",
                            pythonPath = get_python_path,
                        },
                        {
                            name = "Launch pytest",
                            type = "python",
                            request = "launch",
                            module = "pytest",
                            pythonPath = get_python_path,
                        },
                    }
                end,
            })
        end,
        dependencies = { "williamboman/mason.nvim" },
    },
}
