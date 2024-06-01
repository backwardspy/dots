local requires = {
    "curl",
    "gcc",
    "git",
    "tar",
}

return {
    check = function()
        vim.health.start("pigeon")
        for _, exe in ipairs(requires) do
            if vim.fn.executable(exe) ~= 0 then
                vim.health.ok("has "..exe)
            else
                vim.health.error("missing "..exe)
            end
        end
    end,
}
