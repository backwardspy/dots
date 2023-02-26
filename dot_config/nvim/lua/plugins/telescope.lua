return {
  {
    "telescope.nvim",
    opts = function(_, opts)
      -- allow c-t to open a tab rather than trouble
      opts.defaults.mappings.i["<c-t>"] = nil

      -- cache the last few pickers
      opts.defaults.cache_picker = { num_pickers = 3 }
    end,
    keys = {
      { "<leader>fR", "<cmd>Telescope resume<cr>", desc = "Resume Last Picker" },
      { "<leader>fp", "<cmd>Telescope pickers<cr>", desc = "Recent Pickers" },
      { "<leader>fc", "<cmd>Telescope catppuccin<cr>", desc = "Catppuccin Colours" },
    },
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
  {
    "ziontee113/icon-picker.nvim",
    opts = { disable_legacy_commands = true },
    cmd = {
      "IconPickerNormal",
      "IconPickerInsert",
      "IconPickerYank",
    },
  },
}
