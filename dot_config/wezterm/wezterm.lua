local wezterm = require("wezterm")

return {
    font = wezterm.font("Rec Mono Duotone"),
    font_size = string.match(wezterm.target_triple, "darwin") and 15 or 13,
    color_scheme = "Catppuccin Mocha",
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    window_padding = { top = 0, bottom = 0, left = 0, right = 0 },
    keys = {
        {
            key = "f",
            mods = "SHIFT|CTRL",
            action = wezterm.action.ToggleFullScreen,
        }
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
