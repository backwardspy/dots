return {
  {
    "uga-rosa/ccc.nvim",
    opts = {
      default_color = "#CBA6F7",
      highlighter = {
        auto_enable = true,
      },
    },
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    opts = function()
      local ctp = require("catppuccin.palettes").get_palette()
      return {
        highlight = { fg = ctp.yellow },
        symbols = { "─", "│", "┌", "┐", "└", "┘" },
      }
    end,
  },
}
