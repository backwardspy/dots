require("mini.ai").setup()
require("mini.basics").setup({
  mappings = { windows = true },
  autocommands = { basic = false }, -- breaks dap (nvim-dap/issues/439 )
})
require("mini.bracketed").setup()
require("mini.comment").setup()
require("mini.completion").setup()
require("mini.indentscope").setup({ symbol = "│" })
require("mini.jump").setup({ delay = { idle_stop = 3000 } })
require("mini.pairs").setup()
require("mini.sessions").setup()
require("mini.starter").setup()
require("mini.surround").setup()
require("mini.trailspace").setup()

-- i like C-y to accept completions. CR should *always* just insert a newline.
local keys = {
  ["C-y"] = vim.api.nvim_replace_termcodes("<C-y>", true, true, true),
  ["C-y_CR"] = vim.api.nvim_replace_termcodes("<C-y><CR>", true, true, true),
}

_G.cr_action = function()
  if vim.fn.pumvisible() ~= 0 then
    -- if popup is visible, confirm selected item or add new line otherwise
    local item_selected = vim.fn.complete_info()["selected"] ~= -1
    return item_selected and keys["C-y"] or keys["C-y_CR"]
  else
    -- if popup is not visible, use plain `<cr>`.
    return require("mini.pairs").cr()
  end
end

vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })
