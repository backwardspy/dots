-- https://github.com/stevearc/conform.nvim/issues/316#issuecomment-2011707374
local function format()
    local clients = vim.lsp.get_clients()
    for _, client in pairs(clients) do
        if client.supports_method('textDocument/formatting') then
            vim.lsp.buf.format { async = true }
            return
        end
    end
    require('conform').format()
end

return {
    setup = function()
        require("pigeon.keybinds").setup()
        require("pigeon.autocmds").setup()
        require("pigeon.platform").setup()
        require("pigeon.plugins").setup()
    end,
    format = format
}
