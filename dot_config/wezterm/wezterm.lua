local wezterm = require("wezterm")

return {
    font = wezterm.font_with_fallback({
        "Fantasque Sans Mono",
        "Apple Color Emoji",
    }),
    font_size = 16,
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
