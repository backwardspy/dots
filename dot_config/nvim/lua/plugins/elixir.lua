return {
  -- treesitter grammars
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "elixir" })
    end,
  },

  -- language servers
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        ["elixirls"] = {},
      },
    },
  },
}
