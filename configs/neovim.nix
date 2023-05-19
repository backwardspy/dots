{
  pkgs,
  config,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaPackages = ps: with ps; [jsregexp];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink ../ext/neovim;
    recursive = true;
  };

  # lots of treesitter parsers need the C++ stdlib
  programs.fish.functions = {nvim = "env LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib ${pkgs.neovim}/bin/nvim $argv";};

  # the above means we have to set up our own vim/vi/vimdiff aliases
  programs.fish.shellAbbrs = {
    vi = "nvim";
    vim = "nvim";
    vimdiff = "nvim -d";
  };
}
