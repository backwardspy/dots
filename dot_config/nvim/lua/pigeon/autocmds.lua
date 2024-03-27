local group = vim.api.nvim_create_augroup("pigeon", { clear = true })

local format = require("pigeon").format

local function setup()
    vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Format on save",
        group = group,
        pattern = "*",
        callback = format,
    })
end

return {
    group = group,
    setup = setup,
}
