local group = vim.api.nvim_create_augroup("pigeon", { clear = true })

local function setup()
    vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Format on save",
        group = group,
        pattern = "*",
        callback = function() vim.lsp.buf.format() end,
    })
end

return {
    group = group,
    setup = setup,
}
