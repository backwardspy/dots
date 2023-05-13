{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.wezterm];

  xdg.configFile."wezterm" = {
    source = config.lib.file.mkOutOfStoreSymlink ../ext/wezterm;
    recursive = true;
  };

  home.file.".terminfo/w/wezterm".source = ../ext/wezterm_terminfo;
}
