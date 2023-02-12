require("bootstrap").bootstrap_lazy()
require("lazy").setup({
  spec = {
    { import = "shared" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { missing = false },
  change_detection = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
