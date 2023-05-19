{
  pkgs,
  config,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    extraLuaPackages = ps: with ps; [jsregexp];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink ../ext/neovim;
    recursive = true;
  };

  # lots of treesitter parsers need the C++ stdlib
  programs.fish.functions = {nvim = "env LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib ${pkgs.neovim}/bin/nvim $argv";};
}
