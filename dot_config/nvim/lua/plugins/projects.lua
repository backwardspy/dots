return {
  -- install project.nvim as a telescope plugin
  {
    "telescope.nvim",
    dependencies = {
      "ahmedkhalf/project.nvim",
      opts = {
        scope_chdir = "tab",
      },
      config = function(_, opts)
        require("project_nvim").setup(opts)
        require("telescope").load_extension("projects")
      end,
    },
    -- TODO: i don't know why setting keys like this is neccessary.
    -- TODO: if i use a table, it just overrides the defaults.
    keys = function(_, keys)
      vim.list_extend(keys, { { "<leader>pp", "<cmd>Telescope projects<cr>", desc = "Pick project" } })
    end,
  },
  -- improve neotree's ability to switch been projects
  {
    "neo-tree.nvim",
    opts = {
      filesystem = {
        bind_to_cwd = true,
      },
    },
  },
}
