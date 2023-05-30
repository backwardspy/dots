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
  {
    "chrisgrieser/nvim-spider",
    keys = {
      {
        "w",
        function()
          require("spider").motion("w")
        end,
      },
      {
        "e",
        function()
          require("spider").motion("e")
        end,
      },
      {
        "b",
        function()
          require("spider").motion("b")
        end,
      },
    },
  },
}
