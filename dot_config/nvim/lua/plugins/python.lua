local partial = require("functional").partial

return {
  -- treesitter grammars
  {
    "nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "python", "toml" })
      end
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
    opts = {
      sources = {
        require("null-ls").builtins.diagnostics.mypy,
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.formatting.black,
      },
    },
  },
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "isort",
        "mypy",
      }
    }
  }
}
