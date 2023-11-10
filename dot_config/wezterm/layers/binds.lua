local M = {}

M.apply = function(config, wez)
  config.leader = { key = "a", mods="CTRL" }
  config.keys = {
    {
      key = "f",
      mods = "LEADER",
      action = wez.action.ToggleFullScreen,
    },
    {
      key = "z",
      mods = "LEADER",
      action = wez.action.TogglePaneZoomState,
    },
    {
      key = "/",
      mods = "LEADER",
      action = wez.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "-",
      mods = "LEADER",
      action = wez.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "w",
      mods = "LEADER",
      action = wez.action.PaneSelect,
    },
    {
      key = "p",
      mods = "LEADER",
      action = wez.action.ActivateCommandPalette,
    },
  }
  config.mouse_bindings = {
    -- only select with lmb, don't open links
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = wez.action.CompleteSelection("PrimarySelection"),
    },

    -- ctrl+lmb for links
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = wez.action.OpenLinkAtMouseCursor,
    },
  }
end

return M
