local partial = require("functional").partial

return {
  -- treesitter grammars
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "rust", "toml" })
      end
    end,
  },

  -- language servers
  {
    "neovim/nvim-lspconfig",
    dependencies = { "simrat39/rust-tools.nvim" },
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
            },
          },
        },
        taplo = {},
      },
      setup = {
        rust_analyzer = function(_, opts)
          local rt = require("rust-tools")

          -- bind some rust-tools functions on attach
          require("lazyvim.util").on_attach(function(client, bufnr)
            if client.name == "rust_analyzer" then
              local bind = function(key, fn, desc)
                vim.keymap.set("n", key, fn, { buffer = bufnr, desc = desc })
              end

              bind("<A-J>", partial(rt.move_item.move_item, false), "Move Item Down")
              bind("<A-K>", partial(rt.move_item.move_item, true), "Move Item Up")

              bind("K", rt.hover_actions.hover_actions, "Hover Actions")
              bind("<leader>ca", rt.code_action_group.code_action_group, "Code Action Group")
            end
          end)

          rt.setup({ server = opts })

          return true
        end,
      },
    },
  },

  -- show crate updates in Cargo.toml
  {
    "Saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufRead Cargo.toml" },
    config = true,
  },
}
