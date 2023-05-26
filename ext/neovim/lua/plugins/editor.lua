return {
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    cmd = "Git",
    keys = {
      { "<leader>gg", "<cmd>Git<cr>", desc = "Git Status" },
      { "<leader>gG", "<cmd>GBrowse<cr>", desc = "Git Browse" },
    },
    ft = "gitcommit",
  },
}
