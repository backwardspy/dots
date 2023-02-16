return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- test adapters
    "nvim-neotest/neotest-python",
    "rouge8/neotest-rust",
  },
  keys = {
    {
      "<leader>tt",
      function()
        require("neotest").run.run()
      end,
      desc = "Run nearest test",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run tests in current file",
    },
    {
      "<leader>td",
      function()
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "Debug nearest test",
    },
  },
  opts = function(_, opts)
    opts.adapters = {
      require("neotest-python")({
        dap = { justMyCode = false },
      }),
      require("neotest-rust"),
    }
  end,
}
