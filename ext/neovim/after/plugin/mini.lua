local msl = require("mini.statusline")

local section_progress = function(args)
	local progress = vim.lsp.util.get_progress_messages()[1]
	if progress then
		local name = progress.name or ""
		local message = progress.message or ""
		local percentage = progress.percentage or 0
		local title = progress.title or ""

		-- keep redrawing every 500ms until LSP is done loading.
		vim.defer_fn(function()
			vim.cmd("redrawstatus!")
		end, 500)

		if msl.is_truncated(args.trunc_width) then
			return string.format("%s%%%%", percentage)
		else
			return string.format("%s %s %s (%s%%%%)", name, message, title, percentage)
		end
	end
end

local statusline = function()
	local mode, mode_hl = msl.section_mode({ trunc_width = 120 })
	local git = msl.section_git({ trunc_width = 75 })
	local diagnostics = msl.section_diagnostics({ trunc_width = 75 })
	local filename = msl.section_filename({ trunc_width = 140 })
	local lsp_progress = section_progress({ trunc_width = 75 })
	local fileinfo = msl.section_fileinfo({ trunc_width = 120 })
	local location = msl.section_location({ trunc_width = 75 })

	return msl.combine_groups({
		{ hl = mode_hl, strings = { mode } },
		{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
		"%<", -- truncation point
		{ hl = "MiniStatuslineFilename", strings = { filename } },
		"%=",
		{ hl = mode_hl, strings = { lsp_progress } },
		{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
		{ hl = mode_hl, strings = { location } },
	})
end

require("mini.ai").setup()
require("mini.basics").setup({
	mappings = { windows = true },
})
require("mini.bracketed").setup()
require("mini.comment").setup()
require("mini.completion").setup()
require("mini.indentscope").setup({ symbol = "│" })
require("mini.jump").setup({ delay = { idle_stop = 3000 } })
require("mini.pairs").setup()
require("mini.sessions").setup()
require("mini.starter").setup()
msl.setup({ content = { active = statusline } })
require("mini.surround").setup()
require("mini.tabline").setup()
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
