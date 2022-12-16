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

-- double space to go zen mode
vim.keymap.set("n", "<leader><leader>", require("zen-mode").toggle)

-- hotkey modes
local m = { "n", "t", "i" }

-- quicker window movement
vim.keymap.set(m, "<C-h>", [[<cmd>wincmd h<cr>]])
vim.keymap.set(m, "<C-j>", [[<cmd>wincmd j<cr>]])
vim.keymap.set(m, "<C-k>", [[<cmd>wincmd k<cr>]])
vim.keymap.set(m, "<C-l>", [[<cmd>wincmd l<cr>]])

-- easier terminal escape
vim.keymap.set("t", "<c-esc>", [[<C-\><C-n>]])

-- ctrl+p       -> find files
-- ctrl+shift+o -> find symbols
-- ctrl+f       -> search
-- shift+alt+f  -> format file
-- ctrl+s       -> save
-- ctrl+`       -> terminal
-- f2           -> rename
vim.keymap.set(m, "<C-P>", require("telescope.builtin").find_files)
vim.keymap.set(m, "<C-S-O>", require("telescope.builtin").lsp_document_symbols)
vim.keymap.set(m, "<C-F>", require("telescope.builtin").live_grep)
vim.keymap.set(m, "<M-F>", vim.lsp.buf.format)
vim.keymap.set(m, "<C-S>", function()
    vim.api.nvim_command("write")
end)
vim.keymap.set(m, "<F2>", vim.lsp.buf.rename)
