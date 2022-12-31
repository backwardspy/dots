local wezterm = require("wezterm")

wezterm.on("update-status", function(window, pane)
    if pane:get_foreground_process_info().name == "nvim" then
        window:set_config_overrides({
            window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
        })
    else
        window:set_config_overrides({
            window_padding = { left = 8, right = 8, top = 8, bottom = 8 },
        })
    end
end)

return {
    font = wezterm.font("Fantasque Sans Mono", { weight = "Bold" }),
    font_size = string.match(wezterm.target_triple, "darwin") and 15 or 13,
    color_scheme = "Catppuccin Mocha",
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
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
