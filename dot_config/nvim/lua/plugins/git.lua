return {
  {
    "TimUntersberger/neogit",
    dependencies = { "sindrets/diffview.nvim" },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
    opts = {
      integrations = { diffview = true },
    },
    config = function(plugin, opts)
      require(plugin.name).setup(opts)
      vim.api.nvim_create_augroup("neogit-additions", {})
      vim.api.nvim_create_autocmd("FileType", {
        group = "neogit-additions",
        pattern = "NeogitCommitMessage",
        command = "silent! set filetype=gitcommit",
      })
    end,
  },
}
