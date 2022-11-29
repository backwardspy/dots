local wezterm = require("wezterm")

return {
    font = wezterm.font("Fantasque Sans Mono"),
    font_size = string.match(wezterm.target_triple, "darwin") and 18 or 16,
    color_scheme = "Catppuccin Mocha",
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    background = {{
        source = {
            File = os.getenv("HOME") .. "/.config/wezterm/space.jpg",
        },
        hsb = {
            brightness = 0.6,
        },
    }},
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
