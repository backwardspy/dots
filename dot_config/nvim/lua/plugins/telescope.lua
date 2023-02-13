return {
  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "backwardspy/telescope-catppuccin.nvim",
        config = function()
          require("telescope").load_extension("catppuccin")
        end,
      },
      {
        "ThePrimeagen/refactoring.nvim",
        config = function()
          require("refactoring").setup()
          require("telescope").load_extension("refactoring")
          vim.keymap.set("v", "<leader>cR", function()
            require("telescope").extensions.refactoring.refactors()
          end)
        end,
      },
    },
  },
}
