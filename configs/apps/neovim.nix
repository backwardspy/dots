{
  pkgs,
  config,
  flakePath,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;

    package = pkgs.symlinkJoin {
      name = "neovim";
      paths = [pkgs.neovim-unwrapped];
      buildInputs = [pkgs.makeWrapper pkgs.gcc];
      postBuild = "wrapProgram $out/bin/nvim --prefix CC : ${pkgs.lib.getExe pkgs.gcc}";
    };

    extraPackages = with pkgs; [
      # generic tools
      fd
      fzf
      git
      ripgrep

      # build tools
      cargo
      gcc
      lldb
      gnumake
      rustc

      # formatters
      alejandra
      black
      rustfmt

      # language servers
      master.lua-language-server
      nil
      nodePackages.eslint
      nodePackages.pyright
      nodePackages.typescript-language-server
      rust-analyzer
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/ext/neovim";
    recursive = true;
  };
}
