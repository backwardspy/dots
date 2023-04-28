local wezterm = require("wezterm")

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	-- limit text to max_width-2
	local title = tab.active_pane.title
	if #title > max_width - 4 then
		title = string.sub(title, 1, max_width - 4)
	end

	local palette = config.resolved_palette
	local bg = palette.tab_bar.background
	local fg = tab.is_active and palette.background or palette.tab_bar.inactive_tab.bg_color
	local text = palette.foreground

	return {
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = "" },
		{ Background = { Color = fg } },
		{ Foreground = { Color = text } },
		{ Text = " " .. title .. " " },
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = "" },
	}
end)

local americano = function()
	local americano = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
	americano.background = "#000000"
	americano.tab_bar.background = "#040404"
	americano.tab_bar.inactive_tab.bg_color = "#0f0f0f"
	americano.tab_bar.new_tab.bg_color = "#080808"
	return americano
end

local colours = function(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Americano"
	else
		return "Catppuccin Latte"
	end
end

return {
	font = wezterm.font("Rec Mono Duotone"),
	font_size = string.match(wezterm.target_triple, "darwin") and 15 or 11,
	color_schemes = {
		["Catppuccin Americano"] = americano(),
	},
	color_scheme = colours(wezterm.gui.get_appearance()),
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	window_padding = { top = 0, bottom = 0, left = 0, right = 0 },
	initial_rows = 40,
	initial_cols = 120,
	use_resize_increments = true,
	window_background_opacity = string.match(wezterm.target_triple, "linux") and 0.8 or 1,
	keys = {
		{
			key = "f",
			mods = "SHIFT|CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "?",
			mods = "SHIFT|CTRL",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "_",
			mods = "SHIFT|CTRL",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "w",
			mods = "SHIFT|CTRL",
			action = wezterm.action.PaneSelect,
		},
	},
	mouse_bindings = {
		-- only select with lmb, don't open links
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = wezterm.action.CompleteSelection("PrimarySelection"),
		},

		-- ctrl+lmb for links
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
