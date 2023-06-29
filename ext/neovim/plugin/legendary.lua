require("legendary").setup({
  keymaps = {
    { "K",                vim.lsp.buf.hover,                      description = "Show hover doc" },
    { "gh",               vim.diagnostic.open_float,              description = "Show diagnostics" },
    { "<leader>la",       vim.lsp.buf.code_action,                description = "Show code actions" },
    { "<leader>lf",       vim.lsp.buf.format,                     description = "Format buffer" },
    { "<leader>lr",       vim.lsp.buf.rename,                     description = "Rename symbol" },
    { "<C-s>",            ":w<CR>",                               description = "Save" },
    { "<leader>ff",       ":Telescope find_files<CR>",            description = "Find files" },
    { "<leader><leader>", ":Telescope find_files<CR>",            description = "Find files" },
    { "<leader>fb",       ":Telescope buffers<CR>",               description = "Find buffers" },
    { "<leader>fr",       ":Telescope resume<CR>",                description = "Resume last picker" },
    { "<leader>sg",       ":Telescope live_grep<CR>",             description = "Live grep" },
    { "<leader>sk",       ":Legendary<CR>",                       description = "Search custom keymaps" },
    { "<leader>sK",       ":Telescope keymaps<CR>",               description = "Search all keymaps" },
    { "<leader>sh",       ":Telescope help_tags<CR>",             description = "Search help tags" },
    { "gr",               ":Telescope lsp_references<CR>",        description = "Find references to symbol" },
    { "gd",               ":Telescope lsp_definitions<CR>",       description = "Find definitions of symbol" },
    { "<leader>ls",       ":Telescope lsp_document_symbols<CR>",  description = "Search document symbols" },
    { "<leader>lS",       ":Telescope lsp_workspace_symbols<CR>", description = "Search workspace symbols" },
    { "<leader>ld",       ":Telescope diagnostics<CR>",           description = "Show diagnostics" },
    { "<leader>u",        ":Telescope undo<CR>",                  description = "Show undo history" },
  },
  autocmds = {
    {
      "InsertEnter",
      function()
        require("copilot").setup({ suggestion = { auto_trigger = true } })
      end,
      description = "Lazy load Copilot",
    },
    {
      name = "AutoRelativeNumber",
      clear = true,
      { "InsertEnter", ":set norelativenumber", description = "Disable relative numbering" },
      { "InsertLeave", ":set relativenumber",   description = "Enable relative numbering" },
    },
  },
})
