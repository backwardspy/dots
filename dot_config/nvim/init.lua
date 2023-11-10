local opt = vim.opt
opt.shiftwidth = 4
opt.expandtab = true
opt.number = true
opt.relativenumber = true

local group = vim.api.nvim_create_augroup("pigeon", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
    group = group,
    callback = function() opt.relativenumber = false end
})
vim.api.nvim_create_autocmd("InsertLeave", {
    group = group,
    callback = function() opt.relativenumber = true end
})
vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function() vim.highlight.on_yank() end
})
