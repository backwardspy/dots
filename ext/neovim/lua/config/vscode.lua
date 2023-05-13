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

local map = function(keys, action)
  local opts = { noremap = true, silent = true }
  vim.keymap.set("n", keys, function() vim.fn.VSCodeNotify(action) end, opts)
end

map("]d", "editor.action.marker.next")
map("[d", "editor.action.marker.prev")
map("]s", "search.action.focusNextSearchResult")
map("[s", "search.action.focusPreviousSearchResult")

-- wsl clipboard support
if vim.fn.has("wsl") then
  vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = vim.api.nvim_create_augroup("wslyank", { clear = true }),
    callback = function()
      if vim.v.event.regname == '+' then
        vim.fn.system("clip.exe", vim.fn.getreg("+"))
      end
    end,
  })
end
