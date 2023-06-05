return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = function(_, opts)
      local mocha = require("catppuccin.palettes").get_palette("mocha")
      local grey2 = mocha.subtext1
      local grey1 = mocha.subtext0
      local grey0 = mocha.overlay2
      local accent = mocha.pink

      opts.color_overrides = {
        mocha = {
          -- all colours are grey, accents are applied as custom highlights
          rosewater = grey0,
          flamingo = grey0,
          pink = grey0,
          mauve = grey0,
          red = grey0,
          maroon = grey0,
          peach = grey0,
          yellow = grey0,
          green = grey0,
          teal = grey0,
          sky = grey0,
          sapphire = grey0,
          blue = grey0,
          lavender = grey0,

          -- americano-esque base colours
          base = "#000000",
          mantle = "#080808",
          crust = "#0B0B0B",
        },
      }

      opts.custom_highlights = function(colours)
        return {
          Constant = { fg = accent, style = { "bold" } },
          String = { link = "Constant" },
          Character = { link = "Constant" },
          Number = { link = "Constant" },
          Float = { link = "Constant" },
          Boolean = { link = "Constant" },

          Identifier = { fg = colours.text },
          Function = { link = "Identifier" },
          ["@parameter"] = { link = "Identifier" },
          ["@variable"] = { link = "Identifier" },

          Conditional = { style = { "bold" } },
          Repeat = { style = { "bold" } },
          Label = { style = { "bold" } },
          Operator = { style = { "bold" } },

          Keyword = { fg = colours.overlay0, style = { "bold" } },
          ["@keyword.function"] = { link = "Keyword" },
          ["@keyword.operator"] = { link = "Keyword" },
          ["@keyword.return"] = { link = "Keyword" },
          ["@punctuation.delimiter"] = { link = "Keyword" },
          ["@punctuation.bracket"] = { link = "Keyword" },
          ["@punctuation.special"] = { link = "Keyword" },
        }
      end
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
