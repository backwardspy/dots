function PythonEnv()
    for _, client in pairs(vim.lsp.buf_get_clients()) do
        if client.name == "pyright" then
            return client.config.settings.python
        end
    end
    return nil
end
