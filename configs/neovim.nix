{
  pkgs,
  config,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaPackages = ps: with ps; [jsregexp];
    # 🫡 winston
    extraPackages = with pkgs; [
      # generic
      fd
      ripgrep
      tree-sitter
      gcc
      gnumake
      unzip
      # python
      black
      isort
      nodePackages.pyright
      # lua
      stylua
      lua-language-server
      # rust
      cargo
      rust-analyzer
      rustc
      taplo
      # go
      go
      delve
      gofumpt
      gopls
      # nix
      alejandra
      nil
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink ../ext/neovim;
    recursive = true;
  };
}
