local M = {}

local function setup_tab_bar(config, wez)
	wez.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
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

	config.use_fancy_tab_bar = false
	config.hide_tab_bar_if_only_one_tab = true
	config.tab_bar_at_bottom = true
end

local function carbon(wez)
	local custom = wez.color.get_builtin_schemes()["Catppuccin Mocha"]
	custom.background = "#101010"
	custom.tab_bar.background = "#151515"
	custom.tab_bar.inactive_tab.bg_color = "#202020"
	custom.tab_bar.new_tab.bg_color = "#1d1d1d"

	custom.ansi = {
		"#313244",
		"#f38ba8",
		"#8abf8a",
		"#fab387",
		"#89b4fa",
		"#cba6f7",
		"#80bfb5",
		"#9399b2",
	}

	custom.brights = {
		"#6c7086",
		"#eba0ac",
		"#a6e3a1",
		"#f9e2af",
		"#89dceb",
		"#f5c2e7",
		"#94e2d5",
		"#bac2de",
	}

	return custom
end

M.apply = function(config, wez)
	setup_tab_bar(config, wez)

	config.color_schemes = { ["Catppuccin Carbon"] = carbon(wez) }
	config.color_scheme = "Catppuccin Carbon"
	config.bold_brightens_ansi_colors = false

	config.font = wez.font({
          family="Monaspace Neon Var",
          weight = "Bold",
        })
	config.font_size = string.match(wez.target_triple, "darwin") and 13 or 11

	config.default_cursor_style = "BlinkingUnderline"

	config.inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 }

	config.window_padding = { top = 0, bottom = 0, left = 0, right = 0 }
	-- config.window_padding = { top = 32, bottom = 32, left = 32, right = 32 }
	config.use_resize_increments = true
end

return M
