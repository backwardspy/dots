local wk = require("which-key")

wk.setup()

wk.register({
  ["<C-s>"] = { ":w<CR>", "Save" },
  K = { vim.lsp.buf.hover, "Show hover doc" },
  g = {
    name = "Goto",
    d = { ":Telescope lsp_definitions<CR>", "Find definitions of symbol" },
    h = { vim.diagnostic.open_float, "Show diagnostics" },
    r = { ":Telescope lsp_references<CR>", "Find references to symbol" },
  },
})

wk.register({
  ["<leader>"] = { ":Telescope find_files<CR>", "Find files" },
  f = {
    name = "Find",
    b = { ":Telescope buffers<CR>", "Find buffers" },
    f = { ":Telescope find_files<CR>", "Find files" },
    r = { ":Telescope resume<CR>", "Resume last picker" },
  },
  l = {
    name = "LSP",
    S = { ":Telescope lsp_workspace_symbols<CR>", "Search workspace symbols" },
    a = { vim.lsp.buf.code_action, "Show code actions" },
    d = { ":Telescope diagnostics<CR>", "Show diagnostics" },
    f = { vim.lsp.buf.format, "Format buffer" },
    r = { vim.lsp.buf.rename, "Rename symbol" },
    s = { ":Telescope lsp_document_symbols<CR>", "Search document symbols" },
  },
  s = {
    name = "Search",
    g = { ":Telescope live_grep<CR>", "Live grep" },
  },
  h = {
    name = "Help",
    H = { ":Telescope highlights<CR>", "Search highlight groups" },
    h = { ":Telescope help_tags<CR>", "Search help tags" },
    k = { ":Telescope keymaps<CR>", "Search keymaps" },
  },
  u = { ":Telescope undo<CR>", "Show undo history" },
}, { prefix = "<leader>" })
