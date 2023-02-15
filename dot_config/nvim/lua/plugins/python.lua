return {
  -- treesitter grammars
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "python", "toml" })
    end,
  },

  -- language servers
  {
    "nvim-lspconfig",
    dependencies = { "HallerPatrick/py_lsp.nvim" },
    opts = {
      servers = {
        pyright = {},
        taplo = {},
      },
      setup = {
        pyright = function(_, opts)
          local py = require("py_lsp")
          py.setup({ server = opts })
          return true
        end,
      },
    },
  },
  {
    "null-ls.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.sources, {
        require("null-ls").builtins.diagnostics.mypy.with({ prefer_local = ".venv/bin" }),
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.formatting.black,
      })
    end,
  },
  {
    "mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "black",
        "isort",
        "mypy",
      })
    end,
  },
}
