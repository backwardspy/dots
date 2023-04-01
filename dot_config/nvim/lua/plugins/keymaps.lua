return {
  {
    "folke/which-key.nvim",
    opts = function()
      local wk = require("which-key")
      wk.register({
        t = { name = "+test" },
        p = { name = "+project" },
      }, {
        prefix = "<leader>",
      })
    end,
  },
}
