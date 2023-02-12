-- thanks https://github.com/loichyan/dotfiles
local style = "rounded"

return {
  -- lazyvim.plugins.coding
  {
    "nvim-cmp",
    opts = function(_, opts)
      local bordered = require("cmp.config.window").bordered
      return vim.tbl_deep_extend("force", opts, {
        window = {
          completion = bordered(style),
          documentation = bordered(style),
        },
      })
    end,
  },
  -- lazyvim.plugins.editor
  {
    "which-key.nvim",
    opts = { window = { border = style } },
  },
  {
    "gitsigns.nvim",
    opts = { preview_config = { border = style } },
  },
  -- lazyvim.plugins.lsp
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      require("lspconfig.ui.windows").default_options.border = style
      return opts
    end,
  },
  {
    "null-ls.nvim",
    opts = { border = style },
  },
  {
    "mason.nvim",
    opts = {
      ui = { border = style },
    },
  },
  -- lazyvim.plugins.ui
  {
    "noice.nvim",
    opts = {
      presets = { lsp_doc_border = true },
    },
  },
}
