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
    },
  },
}
