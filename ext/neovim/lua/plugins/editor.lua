return {
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    cmd = "Git",
    keys = {
      { "<leader>gg", "<cmd>Git<cr>", desc = "Git Status" },
      { "<leader>gG", "<cmd>GBrowse<cr>", desc = "Git Browse" },
      { "<leader>gP", "<cmd>Git push<cr>", desc = "Git Push" },
      { "<leader>gp", "<cmd>Git pull<cr>", desc = "Git Pull" },
    },
    ft = "gitcommit",
  },
}
