local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- use pwsh on windows
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.launch_menu = {}
  local pwsh_args = { 'pwsh.exe', '-NoLogo' }
  config.default_prog = pwsh_args
  table.insert(config.launch_menu, {
    label = 'PowerShell',
    args = pwsh_args,
  })
end

-- sync colour scheme with os settings
local function appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  else
    return "Dark"
  end
end

local function color_scheme()
  if appearance():find("Dark") then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Latte"
  end
end

config.color_scheme = color_scheme()
local colors = wezterm.color.get_builtin_schemes()[config.color_scheme]

-- ui/tab bar
local tab_left = wezterm.nerdfonts.ple_lower_right_triangle
local tab_right = wezterm.nerdfonts.ple_lower_left_triangle
local tab_transparent = { Color = colors["tab_bar"]["background"] }
local tab_active_bg = { Color = colors["tab_bar"]["active_tab"]["bg_color"] }
local tab_active_fg = { Color = colors["tab_bar"]["active_tab"]["fg_color"] }
local tab_inactive_bg = { Color = colors["tab_bar"]["inactive_tab"]["bg_color"] }
local tab_inactive_fg = { Color = colors["tab_bar"]["inactive_tab"]["fg_color"] }

local function tabify(s, active, max_width)
  local bg = active and tab_active_bg or tab_inactive_bg
  local fg = active and tab_active_fg or tab_inactive_fg

  local lead = wezterm.format({
    { Background = tab_transparent },
    { Foreground = bg },
    { Text = tab_left },
  })

  local text = wezterm.truncate_right(s, max_width - 4)
  local body = wezterm.format({
    { Background = bg },
    { Foreground = fg },
    { Text = " " .. text .. " " },
  })

  local trail = wezterm.format({
    { Background = tab_transparent },
    { Foreground = bg },
    { Text = tab_right },
  })

  return lead .. body .. trail
end

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
  return tabify(tab.active_pane.title, tab.is_active, max_width)
end)

return config
