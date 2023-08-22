return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
    keys = {
      { "<Leader>gg", "<CMD>Neogit<CR>", desc = "Neogit" },
      { "<Leader>gG", "<CMD>Neogit cwd=%:p:h<CR>", desc = "Neogit (current file)" },
    },
    cmd = { "Neogit" },
    opts = {},
  },
}
