local function setup_clipboard()
    if vim.fn.has("wsl") == 1 then
        local copy = "clip.exe"
        local paste = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))'
        vim.g.clipboard = {
            name = "WslClipboard",
            copy = {
                ["+"] = copy,
                ["*"] = copy,
            },
            paste = {
                ["+"] = paste,
                ["*"] = paste,
            },
            cache_enabled = 0,
        }
    end
end

return {
    setup = function() setup_clipboard() end,
}
