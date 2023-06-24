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
      # generic
      gcc
      git

      # language servers
      lua-language-server
      nodePackages.pyright
      python311Packages.ruff-lsp
      rust-analyzer
    ];

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      copilot-lua
      lsp_lines-nvim
      lspkind-nvim
      mini-nvim
      nvim-lspconfig
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-ui-select-nvim
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/ext/neovim";
    recursive = true;
  };
}
