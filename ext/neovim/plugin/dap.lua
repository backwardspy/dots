-- python
local dap_py = require("dap-python")
dap_py.resolve_python = function()
  local env = PythonEnv()
  if env then
    return env.pythonPath
  else
    return vim.fn.expand("~/.nix-profile/bin/python")
  end
end
dap_py.setup()

-- ui
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
