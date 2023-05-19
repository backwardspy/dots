{config, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    extraLuaPackages = ps: with ps; [ jsregexp ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink ../ext/neovim;
    recursive = true;
  };
}
