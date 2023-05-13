return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = os.getenv("appearance") == "light" and "latte" or "mocha",
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "catppuccin" },
    opts = {
      options = {
        section_separators = { left = "▓▒░", right = "░▒▓" },
      },
    },
  },
}
