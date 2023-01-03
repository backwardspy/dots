-- move stuff around in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- make J keep the cursor where it is
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in the middle when scrolling and searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- put without yank
vim.keymap.set("x", "<leader>p", [["_dP]])

-- delete without yank
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- hotkey modes
local m = { "n", "t", "i" }

-- easier terminal escape
vim.keymap.set("t", "<C-Esc>", [[<C-\><C-n>]])

-- ctrl+s to save :)
vim.keymap.set(m, "<C-S>", function()
    vim.api.nvim_command("write")
end)
