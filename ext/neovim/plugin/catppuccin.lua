require("catppuccin").setup({
  flavour = "mocha",
  term_colors = true,
  integrations = {
    mini = true,
    dap = {
      enabled = true,
      enable_ui = true,
    },
    native_lsp = {
      enabled = true,
    },
    treesitter_context = true,
    treesitter = true,
    telescope = true,
    which_key = true,
  }
})
