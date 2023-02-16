local wezterm = require("wezterm")

if string.match(wezterm.target_triple, "linux") then
  wezterm.on("window-focus-changed", function()
    os.execute(
      "xdotool search -classname org.wezfurlong.wezterm | xargs -I{} xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id {}"
    )
  end)
end

local appearance = wezterm.gui.get_appearance():find("Light") and "light" or "dark"

local color_schemes = {
  light = "Catppuccin Latte",
  dark = "Catppuccin Mocha",
}

return {
  font = wezterm.font("Rec Mono Duotone"),
  font_size = string.match(wezterm.target_triple, "darwin") and 17 or 13,
  color_scheme = color_schemes[appearance],
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  window_padding = { top = 0, bottom = 0, left = 0, right = 0 },
  window_background_opacity = string.match(wezterm.target_triple, "linux") and 0.8 or 1,
  set_environment_variables = {
    appearance = appearance,
  },
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
    }, {
    key = "_",
    mods = "SHIFT|CTRL",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
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
