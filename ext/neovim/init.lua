vim.g.mapleader = " "
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.keymap.set("n", "<C-s>", ":w<CR>")

-- set relative number for non-insert modes
vim.o.relativenumber = true
local group = vim.api.nvim_create_augroup("AutoRelNum", {})
vim.api.nvim_create_autocmd({"InsertEnter"}, { group=group, command=":set norelativenumber" })
vim.api.nvim_create_autocmd({"InsertLeave"}, { group=group, command=":set relativenumber" })
