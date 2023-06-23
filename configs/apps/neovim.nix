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

    extraPackages = with pkgs; [
      tree-sitter
      nodejs
      git
      gcc
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      catppuccin-nvim
      mini-nvim
      nvim-web-devicons
      telescope-nvim
      telescope-fzf-native-nvim
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/ext/neovim";
    recursive = true;
  };
}
