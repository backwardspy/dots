local ts = require("telescope")
ts.setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

ts.load_extension("fzf") -- native sorter
ts.load_extension("ui-select") -- use telescope for code actions etc
