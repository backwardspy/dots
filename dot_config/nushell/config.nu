use starship.nu

use catppuccin.nu [catppuccin catppuccin-theme]

$env.config = {
  show_banner: false,
  color_config: (catppuccin-theme latte),
}

# vivid generate THEME | str trim | safe -f ($nu.default-config-dir | path join vivid)
$env.LS_COLORS = (cat ($nu.default-config-dir | path join vivid))
