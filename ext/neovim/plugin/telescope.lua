local ts = require("telescope")
local layouts = require("telescope.pickers.layout_strategies")

local adaptive_layout = function(picker, columns, lines, layout_config)
  if columns < 120 then
    return layouts.vertical(picker, columns, lines, layout_config)
  else
    return layouts.horizontal(picker, columns, lines, layout_config)
  end
end

layouts.adaptive = adaptive_layout

ts.setup({
  defaults = vim.tbl_extend("force", require("telescope.themes").get_ivy(), {
    path_display = { shorten = { len = 3, exclude = { 1, -1 } } },
    layout_config = {
      height = 0.6,
    }
  }),
  pickers = {
    live_grep = {
      layout_strategy = "adaptive",
    }
  },
  extensions = {
    ["ui-select"] = { require("telescope.themes").get_cursor() },
    undo = { layout_strategy = "adaptive" }
  },
})

ts.load_extension("fzf")       -- native sorter
ts.load_extension("ui-select") -- use telescope for code actions etc
ts.load_extension("undo")      -- undo tree
